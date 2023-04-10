extends Control

## The Dialogue System of the game.
##
## Pretty much self-explanatory. Divided into two parts. The text log and the dialogue system. Also the responses are also there.

@onready var dialogue_layer = $DialogueLayer
@onready var textlog = $DialogueLayer/TextLog
@onready var dialogue_box = $DialogueLayer/DialogueBox
@onready var dialogue_characters = $DialogueLayer/DialogueCharacters

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



func _dialogue_visibility_checker():
	if dialogue_box.is_visible():
		dialogue_box.mouse_filter = Control.MOUSE_FILTER_STOP;
	else:
		dialogue_box.mouse_filter = Control.MOUSE_FILTER_PASS;

## Dialogue Related Functions
## END
