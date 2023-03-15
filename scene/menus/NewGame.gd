extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_button_pressed():
	$Sprite2D.hide()
	hide()


func _on_inventory_pressed():
	$Sprite2D.show()


func _on_new_game_button_pressed():
	SceneManager.goto_scene("res://scene/levels/levelexample1.tscn")
	GamePauseUI.toggle_ui(true)
	#GamePauseUi.get_node("PauseCanvasLayer").show() # This has to be the most shittiest way to do stuff oml
