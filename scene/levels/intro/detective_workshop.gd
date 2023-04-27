extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_open_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if Inventory.check_item("Key"):
			SceneManager.goto_level_scene("intro/detective_bedroom.tscn")
		else:
			DialogueScreen.init_dialogue("responses")
		
	
func _on_open_door_mouse_exited():
	$BedroomDoor/Line2D/AnimationPlayer.stop()


func _on_open_door_mouse_entered():
	$BedroomDoor/Line2D/AnimationPlayer.play("glow")



func _on_key_interactable_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$TableCloseup.show()


func _on_return_button_pressed():
	$TableCloseup.hide()


func _on_worktable_key_pressed():
	Inventory.add_item("Key")
	DialogueScreen.init_dialogue("item_get", "detective_item_key")
	$TableCloseup/WorktableKey.queue_free()
	$Key.queue_free()
