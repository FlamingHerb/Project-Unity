extends Control

## The dialogue system of the game.
##
## The following is where the dialogues of the game are
## handled. There are two parts: dialogues and responses.
## The textlog is at the pause menu.
##
## @tutorial:            https://the/tutorial1/url.com
## @tutorial(Tutorial2): https://the/tutorial2/url.com

##===============================================
## Variables
##===============================================

@onready var dialogue_layer = $DialogueLayer
@onready var dialogue_box = $DialogueLayer/DialogueBox
@onready var dialogue_box_text = $DialogueLayer/DialogueBox/DialogueText
@onready var dialogue_box_speaker = $DialogueLayer/DialogueBox/DialogueActorName
@onready var dialogue_next_indicator = $DialogueLayer/DialogueBox/NextIndicator
@onready var dialogue_responses = $DialogueLayer/DialogueResponses
@onready var dialogue_responses_list = $DialogueLayer/DialogueResponses/DialogueWindow/ResponseList
@onready var dialogue_tween
@onready var bust_left = $DialogueLayer/LeftSide
@onready var bust_center = $DialogueLayer/CenterSide
@onready var bust_right = $DialogueLayer/RightSide

## Current state of the dialogue system.
var current_state = State.READY
var dialogue_json_path = "res://assets/data/dialogue/"
var dialogue_bust_path = "res://assets/graphics/character_busts/"
var json_databank
## Tells what id in the dialogue dictionary is taken
var dialogue_next_id
## Dictates whether the player has given input.
var dialogue_gui_input = false
## Dictates speed at which the text is displayed per character.
var text_speed_settings = 1
## Dictates speed of autoplay.
var auto_speed_settings = 1

##===============================================
## Signals
##===============================================

## Emitted when a part of the dialogue is finished.
signal dialogue_part_finished
## Emitted when the 'end' command is reached.
signal dialogue_all_finished
## Emitted when a response is taken.
## Coupled with 'await DialogueScreen.response_taken' to wait for response.
signal response_taken(index)

##===============================================
## Enumerations
##===============================================

## States the following state of the dialogue system.
enum State {
	READY,
	READING,
	FINISHED
}

##===============================================
## Godot Processing functions
##===============================================

func _ready():
	pass


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match current_state:
		State.READY:
			pass
		State.READING:
			if dialogue_gui_input or Input.is_action_just_pressed("ui_accept"): #FIXME: Find roundabout way to fix mouse clicks. 
				dialogue_gui_input = false
				dialogue_tween.stop()
				dialogue_box_text.visible_ratio = 1
				_finish_dialogue()
		State.FINISHED:
			if dialogue_gui_input or Input.is_action_just_pressed("ui_accept"): #FIXME: Find roundabout way to fix mouse clicks.
				dialogue_part_finished.emit()
				dialogue_gui_input = false
				_process_dialogue(dialogue_next_id)
				dialogue_next_indicator.hide()

##===============================================
## Textlog- and UI-Related Function
##===============================================

## Updates the textlog.
func _update_textlog(actor, line):
	GamePauseUI.textlog_text.append_text(actor + ": " + line + "\n")

## Toggles UI
func toggle_ui(value):
	if value:
		dialogue_layer.show()
	else:
		dialogue_layer.hide()

##===============================================
## Dialogue-Related Function
##===============================================

## Clears data for the next sequence of events.
func _clear_data():
	# Returns ownership and clears memory.
	json_databank = null
	dialogue_next_id = null
	
	# Hides all dialogue boxes
	dialogue_box.hide()
	dialogue_responses.hide()

	# Clear all items regardless if they were called
	_clear_dialogue_box()
	_clear_responses()

	_change_state(State.READY)

## Loads the appropriate JSON Dialogue databank for the following scene.
## ID 000 will consequently be—and always—the first dialogue when loading.
## That is without any parameters to the dialogue_key.
func init_dialogue(path, dialogue_key:String = "000"):
	json_databank = read_from_JSON(dialogue_json_path + path + ".json")
	_process_dialogue(dialogue_key)

## Processes current dialogue by the game.
func _process_dialogue(dialogue_id):
	if dialogue_next_id == "end":
		_clear_data()
		dialogue_all_finished.emit()
		return

	# Gets data first
	var current_dialogue_data = json_databank[dialogue_id]

	# IF THE FOLLOWING IS A DIALOGUE
	if current_dialogue_data["type"] == "basic":
		dialogue_tween = get_tree().create_tween()
		# Shows dialogue JUST IN CASE.
		dialogue_box.show()
		dialogue_responses.hide()

		# Sets characters to an invisible state
		dialogue_box_text.visible_characters = 0

		# Sets and updates speaker data
		if current_dialogue_data["speaker"] != "none":
			dialogue_box_speaker.bbcode_text = current_dialogue_data["speaker"]
		else:
			dialogue_box_speaker.bbcode_text = " "
		dialogue_box_text.bbcode_text = current_dialogue_data["text"]
		_update_textlog(current_dialogue_data["speaker"], current_dialogue_data["text"])

		# Setting up next ID for reading.
		dialogue_next_id = current_dialogue_data["next_id"] # TODO: Redo this with interpreter.

		_change_state(State.READING)
		
		var current_dialogue_character_count = dialogue_box_text.get_total_character_count()
		var current_dialogue_speed = (float(current_dialogue_character_count) / 20) / text_speed_settings 
		#print(current_dialogue_speed)

		dialogue_tween.tween_property(dialogue_box_text, "visible_characters", current_dialogue_character_count, current_dialogue_speed)

		dialogue_tween.tween_callback(_finish_dialogue)

	# IF THE FOLLOWING IS A RESPONSE
	# Gets data first for responses (CRUCIAL!)
	if current_dialogue_data["type"] == "response":
		# Changes state to ready JUST IN CASE
		_change_state(State.READY)

		# Visibility checks
		dialogue_box.hide()

		# ALWAYS CLEAR RESPONSES
		_clear_responses()
	
		var current_responses = current_dialogue_data["responses"]
		#print(current_responses)
		for i in current_responses:
			dialogue_responses_list.add_item(current_responses[i]["text"])
		
		# Shows dialogue box.
		dialogue_responses.show()


		# Waits for input
		var selected_index = await dialogue_responses_list.item_clicked
		# Processing next state (different from dialogue due to circumstances)
		dialogue_next_id = current_responses[str(selected_index[0])]["next_id"]
		
		# Emits signal to tell which option was taken.
		response_taken.emit(selected_index[0])

		#print("Next Dialogue ID:" + dialogue_next_id)
		_process_dialogue(dialogue_next_id)


## Calls after finishing the dialogue.
func _finish_dialogue():
	_change_state(State.FINISHED)
	dialogue_next_indicator.show()


## Clears the dialogue box before the next sequence and
## after the following sequences..
func _clear_dialogue_box():
	dialogue_box_speaker.bbcode_text = " "
	dialogue_box_text.bbcode_text = " "


## Clears the responses after use.
func _clear_responses():
	dialogue_responses_list.clear()


## Changes state of the current dialogue system.
func _change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Waiting for next dialogue.")
		State.READING:
			print("Reading current dialogue.")
		State.FINISHED:
			print("Finished reading dialogue. Awaiting input.")


## Changes the dialogue bust in the bust section.
func change_dialogue_bust(bust_filename, bust_position):
	match bust_position:
		0:
			bust_left.texture = load(dialogue_bust_path + bust_filename)
		1:
			bust_center.texture = load(dialogue_bust_path + bust_filename)
		2:
			bust_right.texture = load(dialogue_bust_path + bust_filename)


## Shows the bust in the bust section.
func show_bust(bust_position):
	match bust_position:
		0:
			bust_left.show()
		1:
			bust_center.show()
		2:
			bust_right.show()
		3:
			bust_left.show()
			bust_center.show()
			bust_right.show()


## Hides the bust in the bust section.
func hide_bust(bust_position):
	match bust_position:
		0:
			bust_left.hide()
		1:
			bust_center.hide()
		2:
			bust_right.hide()
		3:
			bust_left.hide()
			bust_center.hide()
			bust_right.hide()


## Clears the bust section when dialogue is over.
func clear_bust(bust_position):
	match bust_position:
		0:
			bust_left.texture = null
		1:
			bust_center.texture = null
		2:
			bust_right.texture = null
		3:
			bust_left.texture = null
			bust_center.texture = null
			bust_right.texture = null


##===============================================
## Other related functions
##===============================================


## Reads JSON file from path.
func read_from_JSON(path):
	var file = FileAccess.open(path, FileAccess.READ) #Will close in here anyway.
	return JSON.parse_string(file.get_as_text())


func _on_dialogue_box_gui_input(event:InputEvent):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		dialogue_gui_input = true


func _on_dialogue_box_visibility_changed():
	if dialogue_box.is_visible():
		dialogue_box.mouse_filter = Control.MOUSE_FILTER_STOP;
	else:
		dialogue_box.mouse_filter = Control.MOUSE_FILTER_PASS;


func _on_dialogue_responses_visibility_changed():
	if dialogue_responses.is_visible():
		dialogue_responses.mouse_filter = Control.MOUSE_FILTER_STOP;
	else:
		dialogue_responses.mouse_filter = Control.MOUSE_FILTER_PASS;


func _on_response_list_item_clicked(_index, _at_position, _mouse_button_index):
	dialogue_responses.hide()
