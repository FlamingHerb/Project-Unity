extends Node

# array for Music that requires a Queue
# @onready var _soundQueuesByName = {}

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
	$SFXAudioQueue/Thunder.stream = load("res://assets/audio/sfx/thunder.mp3")
	$SFXAudioQueue/OpenedDoor.stream = load("res://assets/audio/sfx/opened_door.mp3")
	$SFXAudioQueue/LockedDoor.stream = load("res://assets/audio/sfx/locked_door.mp3")
	$SFXAudioQueue/DoorKnock.stream = load("res://assets/audio/sfx/door_knock.mp3")
	$SFXAudioQueue/DoorBang.stream = load("res://assets/audio/sfx/door_bang.mp3")
	$SFXAudioQueue/DoorKey.stream = load("res://assets/audio/sfx/door_key.mp3")
	$SFXAudioQueue/RadioTune.stream = load("res://assets/audio/sfx/radio_tune.mp3")
	$SFXAudioQueue/PaperRustle.stream = load("res://assets/audio/sfx/paper_rustle.mp3")
	$SFXAudioQueue/PaperTear.stream = load("res://assets/audio/sfx/paper_tear.mp3")
	$SFXAudioQueue/BottleClink.stream = load("res://assets/audio/sfx/bottle_clink.mp3")
	$SFXAudioQueue/GunCock.stream = load("res://assets/audio/sfx/gun_cock.mp3")
	$SFXAudioQueue/MagazineReload.stream = load("res://assets/audio/sfx/magazine_reload.mp3")
	$SFXAudioQueue/PuzzleButton.stream = load("res://assets/audio/sfx/puzzle_button.mp3")
	$AmbienceAudioQueue/Room.stream = load("res://assets/audio/ambience/thunder_rain.mp3")

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
		"thunder":
			$SFXAudioQueue/Thunder.play()
		"opened_door":
			$SFXAudioQueue/OpenedDoor.play()
		"locked_door":
			$SFXAudioQueue/LockedDoor.play()
		"door_knock":
			$SFXAudioQueue/DoorKnock.play()
		"door_bang":
			$SFXAudioQueue/DoorBang.play()
		"door_key":
			$SFXAudioQueue/DoorKey.play()
		"radio_tune":
			$SFXAudioQueue/RadioTune.play()
		"paper_rustle":
			$SFXAudioQueue/PaperRustle.play()
		"paper_tear":
			$SFXAudioQueue/PaperTear.play()
		"bottle_clink":
			$SFXAudioQueue/BottleClink.play()
		"gun_cock":
			$SFXAudioQueue/GunCock.play()
		"magazine_reload":
			$SFXAudioQueue/MagazineReload.play()
		"room":
			if not $AmbienceAudioQueue/Room.is_playing():
				$AmbienceAudioQueue/Room.play()
		"puzzle_button":
			$SFXAudioQueue/PuzzleButton.play()
		_:
			print("Sound not found:", sound)

func stop_sound(sound: String):
	match sound:
		"main_menu":
			$MusicAudioQueue/MusicStream.stop()
		"room":
			$AmbienceAudioQueue/Room.stop()
		"bottle_clink":
			$SFXAudioQueue/BottleClink.stop()
		"paper_tear":
			$SFXAudioQueue/PaperTear.stop()
		"paper_rustle":
			$SFXAudioQueue/PaperRustle.stop()
		"radio_tune":
			$SFXAudioQueue/RadioTune.stop()
		"gun_cock":
			$SFXAudioQueue/GunCock.stop()
		"magazine_reload":
			$SFXAudioQueue/MagazineReload.stop()
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
