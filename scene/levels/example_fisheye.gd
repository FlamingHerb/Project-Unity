extends Node

@onready var fisheye_container = $FisheyeContainer

# Called when the node enters the scene tree for the first time.
func _unhandled_input(event):
	if event is InputEventMouseMotion and event.button_mask > 0:
		fisheye_container.position.x = clampf(fisheye_container.position.x + event.relative.x, -1680, 0)