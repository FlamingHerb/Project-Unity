extends Control

@onready var textlog = $PauseCanvasLayer/TextLog
@onready var textlog_text = $PauseCanvasLayer/TextLog/TextLogText #FIXME: WHY


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func toggle_ui(value):
	if value:
		$PauseCanvasLayer.show()
	else:
		$PauseCanvasLayer.hide()

func _on_pause_button_pressed():
	get_tree().paused = true
	$PauseCanvasLayer/PauseMenu.show()


func _on_inventory_button_pressed():
	get_tree().paused = true
	$PauseCanvasLayer/InventoryMenu.show()


func _on_text_log_button_pressed():
	get_tree().paused = true
	textlog.show()


func _on_text_log_close_button_pressed():
	get_tree().paused = false
	textlog.hide()
