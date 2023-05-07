extends Node

# array for Music that requires a Queue
@onready var _soundQueuesByName = {}

@onready var ui_click := $BtnAudioQueue/UiClick
@onready var ui_hover := $BtnAudioQueue/UiHover

var is_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $BtnAudioQueue.get_children():
		child.bus = &"SFX"
	for child in $MusicAudioQueue.get_children():
		child.bus = &"Music"
	for child in $SFXAudioQueue.get_children():
		child.bus = &"SFX"
	for child in $AmbienceAudioQueue.get_children():
		child.bus = &"Ambience"
		
	# Load Audio Assets
	ui_click.stream = load("res://assets/audio/sfx/ui_click.mp3")
	ui_hover.stream = load("res://assets/audio/sfx/ui_hover.mp3")
	$MusicAudioQueue/MusicStream.stream = load("res://assets/audio/music/main_menu.mp3")
	$SFXAudioQueue/OpenedDoor.stream = load("res://assets/audio/sfx/opened_door.mp3")
	$SFXAudioQueue/LockedDoor.stream = load("res://assets/audio/sfx/locked_door.mp3")
	$SFXAudioQueue/DoorKey.stream = load("res://assets/audio/sfx/door_key.mp3")
	$AmbienceAudioQueue/Room.stream = load("res://assets/audio/ambience/room.wav")

func _process(_delta):
	pass

func play_sound(sound: String):
	match sound:
		"ui_click":
			ui_click.play()
		"ui_hover":
			ui_hover.play()
		"main_menu":
			$MusicAudioQueue/MusicStream.play()
		"opened_door":
			$SFXAudioQueue/OpenedDoor.play()
		"locked_door":
			$SFXAudioQueue/LockedDoor.play()
		"door_key":
			$SFXAudioQueue/DoorKey.play()
		"room":
			$AmbienceAudioQueue/Room.play()
		_:
			print("Sound not found:", sound)

func stop_sound(sound: String):
	match sound:
		"main_menu":
			$MusicAudioQueue/MusicStream.stop()
		"room":
			$AmbienceAudioQueue/Room.stop()
		_:
			print("Sound not found:", sound)

func _enter_tree() -> void:
	# This is the earliest time we can connect to the SceneTree node_added signal in _enter_tree() to catch all the nodes
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node: Node)->void:
	# We need to wait until this node is ready to connect the signals to our stream players or they will be null
	if not is_ready:
		await ready
		is_ready = true

	if node is Button:
		node.pressed.connect(ui_click.play)
		node.mouse_entered.connect(ui_hover.play)
