extends Control

## The Dialogue System of the game.
##
## Pretty much self-explanatory. Divided into two parts. The text log and the dialogue system. Also the responses are also there.


@onready var textlog_layer = $DialogueLayer
@onready var textlog = $DialogueLayer/TextLog

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_dialogue_visibility_checker() # TODO: Super distressing, please fix!
	pass

## Text Log Related Functions
## START

func toggle_ui(value):
	if value:
		textlog_layer.show()
	else:
		textlog_layer.hide()

func _on_text_log_button_pressed():
	textlog.show()

func _on_text_log_close_button_pressed():
	textlog.hide()

## Text Log Related Functions
## END


## Dialogue Related Functions
## START

func _dialogue_visibility_checker():
	if $DialogueLayer/DialogueBox.is_visible():
		print("stop")
		self.mouse_filter = Control.MOUSE_FILTER_STOP;
	else:
		self.mouse_filter = Control.MOUSE_FILTER_PASS;

## Dialogue Related Functions
## END
