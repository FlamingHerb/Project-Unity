extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalDatabase.check_switch("bedroom_dialogue") == false:
		DialogueScreen.init_dialogue("prologue_dialogue", "Getting Ready")
		GlobalDatabase.toggle_switch("bedroom_dialogue", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_door_pressed():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")

func _on_door_mouse_exited():
	$Door/AnimationPlayer.stop()

func _on_door_mouse_entered():
	$Door/AnimationPlayer.play("door_outline")



func _on_duffel_bag_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_bedroom_interact", "Duffle Bag")
		var respon = await DialogueScreen.response_taken
		if respon == 0:
			GamePauseUI.toggle_ui(false)
			DialogueScreen.toggle_ui(false)
			SceneManager.goto_level_scene("cutscene/middle.tscn")

func _on_closet_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_bedroom_interact", "Closet")
