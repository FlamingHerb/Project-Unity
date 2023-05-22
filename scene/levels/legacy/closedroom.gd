extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_closed_door_input_event(_viewport, event, _shape_idx):
	if GlobalDatabase.is_mouse_clicked(event):
		AudioManager.play_opened_door()
		SceneManager.goto_scene("res://scene/levels/junction.tscn")
