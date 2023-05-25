extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalDatabase.check_switch("door_knocking"):
		$Main/Background.hide()

	GlobalDatabase.set_flavor_location("Front Entrance")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		if GlobalDatabase.check_switch("intruder"):
			DialogueScreen.init_dialogue("prologue_front_interact", "Intruder")
			return
		
		# TODO: Cutscene
		if GlobalDatabase.check_switch("door_knocking"):
			DialogueScreen.init_dialogue("prologue_dialogue", "Door Intruder")
			AudioManager.play_sound("door_knock")
			await DialogueScreen.dialogue_all_finished
			$FrontDoorLook.show()

			DialogueScreen.init_dialogue("prologue_dialogue", "DI1")
			await DialogueScreen.dialogue_all_finished

			# Jumpscare, door banging.

			DialogueScreen.init_dialogue("prologue_dialogue", "DI2")
			AudioManager.play_sound("door_bang")
			await DialogueScreen.dialogue_all_finished

			$FrontDoorLook.hide()

			# Door being knocked

			DialogueScreen.init_dialogue("prologue_dialogue", "DI3")
			await DialogueScreen.dialogue_all_finished

			# Finale begins
			GlobalDatabase.toggle_switch("intruder", true)
			GlobalTimer.ready_time(30)
		else:
			DialogueScreen.init_dialogue("prologue_front_interact", "No Reason")
			return


func _on_left_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")

func _on_right_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_kitchen.tscn")
