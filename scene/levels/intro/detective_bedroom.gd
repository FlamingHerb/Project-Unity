extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDatabase.set_flavor_location("Bedroom")

	if GlobalDatabase.check_switch("door_knocking"):
		$Main/Background.hide()

	if GlobalDatabase.check_switch("finale_sequence") && GlobalDatabase.check_switch("bedroom_dialogue_2") == false:
		$Main/Background.hide()
		DialogueScreen.init_dialogue("prologue_dialogue", "Pre-Finale Dialogue")
		await DialogueScreen.dialogue_all_finished
		GlobalDatabase.toggle_switch("door_knocking", true)
		GlobalDatabase.toggle_switch("bedroom_dialogue_2", true)

	if GlobalDatabase.check_switch("bedroom_dialogue") == false:
		DialogueScreen.init_dialogue("prologue_dialogue", "Getting Ready")
		GlobalDatabase.toggle_switch("bedroom_dialogue", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# func _on_duffel_bag_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
# 	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
# 		DialogueScreen.init_dialogue("prologue_bedroom_interact", "Duffle Bag")
# 		var respon = await DialogueScreen.response_taken
# 		if respon == 0:
# 			GamePauseUI.toggle_ui(false)
# 			DialogueScreen.toggle_ui(false)
# 			SceneManager.goto_level_scene("cutscene/middle.tscn")

func _on_closet_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if GlobalDatabase.check_switch("bag_taken"):
			DialogueScreen.init_dialogue("prologue_bedroom_interact", "Closet")
			return
		if GlobalDatabase.check_switch("puzzle_solved"):
			DialogueScreen.init_dialogue("prologue_bedroom_interact", "Closet - Puzzle Solved")
			await DialogueScreen.dialogue_all_finished
			GlobalDatabase.toggle_switch("bag_taken", true)
			$Main/DuffelBag.show()
			return
		else:
			DialogueScreen.init_dialogue("prologue_bedroom_interact", "Closet")
			return


func _on_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SceneManager.goto_level_scene("intro/detective_workshop.tscn")


func _on_drawer_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#GlobalTimer.ready_time(10)
		$Main.hide()
		$DrawerCloseup.show()


func _on_box_return_button_pressed():
	$Main.show()
	$DrawerCloseup.hide()


func _on_gun_pressed():
	DialogueScreen.init_dialogue("prologue_bedroom_interact", "Gun")
	Inventory.add_item("Gun")
	$DrawerCloseup/Gun.queue_free()


func _on_duffel_bag_pressed():
	DialogueScreen.init_dialogue("prologue_bedroom_interact", "Duffle Bag")
	var respon = await DialogueScreen.response_taken
	if respon == 0:
		GamePauseUI.toggle_ui(false)
		DialogueScreen.toggle_ui(false)
		GlobalDatabase.toggle_switch("finale_sequence", true)
		SceneManager.goto_level_scene("cutscene/middle.tscn")



func _on_pillow_return_button_pressed():
	$Main.show()
	$PillowCloseup.hide()

func _on_pillow_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$PillowCloseup.show()
		$Main.hide()


func _on_magazine_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_bedroom_interact", "Magazine")
		Inventory.add_item("Magazine")
		$Main/Pillow.queue_free()
		$Main.show()
		$PillowCloseup.hide()
