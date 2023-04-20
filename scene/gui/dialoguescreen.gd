extends Control

## TODO: CLEAN SHIT DUDE HOLY CRAP THIS THING SUCKS LMAO
## The Dialogue System of the game.
##
## Pretty much self-explanatory. Divided into two parts. The text log and the dialogue system. Also the responses are also there.

enum State {
	READY,
	READING,
	FINISHED
}

@onready var dialogue_layer = $DialogueLayer
@onready var textlog = $DialogueLayer/TextLog
@onready var textlog_text = $DialogueLayer/TextLog/MarginContainer/MarginContainer/TextLogText #FIXME: WHY
@onready var dialogue_box = $DialogueLayer/DialogueBox
@onready var dialogue_box_text = $DialogueLayer/DialogueBox/DialogueText
@onready var dialogue_box_speaker = $DialogueLayer/DialogueBox/DialogueActorName
@onready var dialogue_next_indicator = $DialogueLayer/DialogueBox/NextIndicator
@onready var dialogue_characters = $DialogueLayer/DialogueCharacters
@onready var dialogue_responses = $DialogueLayer/DialogueResponses
@onready var dialogue_responses_list = $DialogueLayer/DialogueResponses/DialogueWindow/ResponseList
@onready var dialogue_tween

var current_state = State.READY
var dialogue_json_path = "res://assets/data/dialogue/"
var json_databank
var dialogue_next_id
var dialogue_gui_input = false
var text_speed_settings = 1
var auto_speed_settings = 1


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
				dialogue_gui_input = false
				_process_dialogue(dialogue_next_id)
				dialogue_next_indicator.hide()

## Text Log Related Functions
## START

func _update_textlog(actor, line):
	textlog_text.append_text(actor + ": " + line + "\n")

func toggle_ui(value):
	if value:
		dialogue_layer.show()
	else:
		dialogue_layer.hide()

func _on_text_log_button_pressed():
	textlog.show()

func _on_text_log_close_button_pressed():
	textlog.hide()

## Text Log Related Functions
## END


## Dialogue Related Functions
## START

# Clears data for the next sequence of events.
func _clear_data():
	# Returns ownership and clears memory.
	json_databank = null
	dialogue_next_id = null
	
	# Hides all dialogue boxes
	dialogue_box.hide()
	dialogue_characters.hide()
	dialogue_responses.hide()

	# Clear all items regardless if they were called
	_clear_dialogue_box()
	_clear_responses()

	change_state(State.READY)

# Loads the appropriate JSON Dialogue databank for the following scene.
# Rememeber that ID 000 will consequently be—and always—the first dialogue when loading.
func init_dialogue(path, dialogue_key:String = "000"):
	json_databank = read_from_JSON(dialogue_json_path + path + ".json")
	_process_dialogue(dialogue_key)

# Processes current dialogue by the game.
func _process_dialogue(dialogue_id):
	if dialogue_next_id == "end":
		_clear_data()
		return

	# Gets data first
	var current_dialogue_data = json_databank[dialogue_id]

	#=====================================================
	# START - IF THE FOLLOWING IS A DIALOGUE
	#=====================================================
	if current_dialogue_data["type"] == "basic":
		dialogue_tween = get_tree().create_tween()
		# Shows dialogue JUST IN CASE.
		dialogue_box.show()
		dialogue_characters.show()
		dialogue_responses.hide()

		# Sets characters to an invisible state
		dialogue_box_text.visible_characters = 0

		# Sets and updates speaker data
		if current_dialogue_data["speaker"] != "none":
			dialogue_box_speaker.bbcode_text = current_dialogue_data["speaker"]
		dialogue_box_text.bbcode_text = current_dialogue_data["text"]
		_update_textlog(current_dialogue_data["speaker"], current_dialogue_data["text"])

		# Setting up next ID for reading.
		dialogue_next_id = current_dialogue_data["commands"][0] # TODO: Redo this with interpreter.

		change_state(State.READING)
		
		var current_dialogue_character_count = dialogue_box_text.get_total_character_count()
		var current_dialogue_speed = (float(current_dialogue_character_count) / 20) / text_speed_settings 
		print(current_dialogue_speed)

		dialogue_tween.tween_property(dialogue_box_text, "visible_characters", current_dialogue_character_count, current_dialogue_speed)

		dialogue_tween.tween_callback(_finish_dialogue)
	#=====================================================
	# END - IF THE FOLLOWING IS A DIALOGUE
	#=====================================================

	#=====================================================
	# START - IF THE FOLLOWING IS A RESPONSE
	#=====================================================
	# Gets data first for responses (CRUCIAL!)
	if current_dialogue_data["type"] == "response":
		# Changes state to ready JUST IN CASE
		change_state(State.READY)

		# Visibility checks
		dialogue_box.hide()
		dialogue_characters.hide()

		# ALWAYS CLEAR RESPONSES
		_clear_responses()
	
		var current_responses = current_dialogue_data["responses"]
		print(current_responses)
		for i in current_responses:
			dialogue_responses_list.add_item(current_responses[i]["text"])
		
		# Shows dialogue box.
		dialogue_responses.show()

		# Waits for input
		var selected_index = str(await dialogue_responses_list.item_activated)

		# Processing next state (different from dialogue due to circumstances)
		dialogue_next_id = current_responses[selected_index]["commands"][0]
		print(dialogue_next_id)
		_process_dialogue(dialogue_next_id)


func _finish_dialogue():
	change_state(State.FINISHED)
	dialogue_next_indicator.show()

func _clear_dialogue_box():
	dialogue_box_speaker.bbcode_text = " "
	dialogue_box_text.bbcode_text = " "

func _clear_responses():
	dialogue_responses_list.clear()

# Changes state
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Waiting for next dialogue.")
		State.READING:
			print("Reading current dialogue.")
		State.FINISHED:
			print("Finished reading dialogue. Awaiting input.")


## Dialogue Related Functions
## END

# Reads JSON file.
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

# Crucial
func _on_response_list_item_activated(_index):
	dialogue_responses.hide()
