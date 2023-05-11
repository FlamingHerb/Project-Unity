extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDatabase.set_flavor_location("Detective's Bedroom")

	if GlobalDatabase.check_switch("bedroom_dialogue") == false:
		DialogueScreen.init_dialogue("prologue_dialogue", "Getting Ready")
		GlobalDatabase.toggle_switch("bedroom_dialogue", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

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


func _on_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SceneManager.goto_level_scene("intro/detective_workshop.tscn")


func _on_drawer_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Main.hide()
		$DrawerCloseup.show()


func _on_box_return_button_pressed():
	$Main.show()
	$DrawerCloseup.hide()


func _on_gun_pressed():
	Inventory.add_item("Gun")
	$DrawerCloseup/Gun.queue_free()
