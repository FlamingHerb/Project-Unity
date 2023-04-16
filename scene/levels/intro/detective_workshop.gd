extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_open_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SceneManager.goto_level_scene("intro/detective_bedroom.tscn")
	
func _on_open_door_mouse_exited():
	$BedroomDoor/Line2D/AnimationPlayer.stop()


func _on_open_door_mouse_entered():
	$BedroomDoor/Line2D/AnimationPlayer.play("glow")

