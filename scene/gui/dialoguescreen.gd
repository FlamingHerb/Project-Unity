extends Control

## The Dialogue System of the game.
##
## Pretty much self-explanatory. Divided into two parts. The text log and the dialogue system. Also the responses are also there.

@onready var dialogue_layer = $DialogueLayer
@onready var textlog = $DialogueLayer/TextLog
@onready var dialogue_box = $DialogueLayer/DialogueBox
@onready var dialogue_box_text = $DialogueLayer/DialogueBox/DialogueText
@onready var dialogue_box_speaker = $DialogueLayer/DialogueBox/DialogueActorName
@onready var dialogue_characters = $DialogueLayer/DialogueCharacters
#@onready var dialogue_tween = get_tree().create_tween()

var dialogue_json_path = "res://assets/data/dialogue/"
var json_databank


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_dialogue_visibility_checker() # TODO: Super distressing, please fix!
	pass

## Text Log Related Functions
## START

func toggle_ui(value):
	if value:
		dialogue_layer.show()
		#dialogue_box.show()
		#dialogue_characters.show()
	else:
		dialogue_layer.hide()
		#dialogue_box.hide()
		#dialogue_characters.hide()

func _on_text_log_button_pressed():
	textlog.show()

func _on_text_log_close_button_pressed():
	textlog.hide()

## Text Log Related Functions
## END


## Dialogue Related Functions
## START

# Loads the appropriate JSON Dialogue databank for the following scene.
# Rememeber that ID 000 will consequently be—and always—the first dialogue when loading.
func init_dialogue(path):
	json_databank = read_from_JSON(dialogue_json_path + path + ".json")
	dialogue_box.show()
	dialogue_characters.show()
	_process_dialogue("000")

# Processes current dialogue by the game.
func _process_dialogue(dialogue_id):
	var dialogue_tween = get_tree().create_tween()
	var current_dialogue_data = json_databank[dialogue_id]
	dialogue_box_text.visible_ratio = 0

	dialogue_box_speaker.bbcode_text = current_dialogue_data["speaker"]
	dialogue_box_text.bbcode_text = current_dialogue_data["text"]

	dialogue_tween.tween_property($DialogueLayer/DialogueBox/DialogueText, "visible_ratio", 1, 1)
	

func _dialogue_visibility_checker():
	if dialogue_box.is_visible():
		dialogue_box.mouse_filter = Control.MOUSE_FILTER_STOP;
	else:
		dialogue_box.mouse_filter = Control.MOUSE_FILTER_PASS;

## Dialogue Related Functions
## END

# Reads JSON file.
func read_from_JSON(path):
	var file = FileAccess.open(path, FileAccess.READ) #Will close in here anyway.
	return JSON.parse_string(file.get_as_text())
