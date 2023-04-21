extends Node

@onready var fisheye_container = $FisheyeContainer

func _ready():
	SceneManager.debug_test()

# Called when the node enters the scene tree for the first time.
func _unhandled_input(event):
	if event is InputEventMouseMotion and event.button_mask > 0:
		fisheye_container.position.x = clampf(fisheye_container.position.x + event.relative.x, -1680, 0)

func _on_texture_button_pressed():
	DialogueScreen.init_dialogue("example_talk")
	DialogueScreen.change_dialogue_bust("standin_neutral.png", 1)
	DialogueScreen.show_bust(1)
	await DialogueScreen.dialogue_all_finished
	print("Dialogue finished")
	DialogueScreen.hide_bust(1)
