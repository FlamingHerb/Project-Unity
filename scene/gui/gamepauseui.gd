extends Control


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
	pass # Replace with function body.
