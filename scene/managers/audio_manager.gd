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
	
	# Load Audio Assets
	ui_click.stream = load("res://assets/audio/sfx/ui_click.mp3")
	ui_hover.stream = load("res://assets/audio/sfx/ui_hover.mp3")
	$MusicAudioQueue/MusicStream.stream = load("res://assets/audio/music/main_menu.mp3")
	$SFXAudioQueue/OpenedDoor.stream = load("res://assets/audio/sfx/opened_door.mp3")
	$SFXAudioQueue/LockedDoor.stream = load("res://assets/audio/sfx/locked_door.mp3")
	$SFXAudioQueue/DoorKey.stream = load("res://assets/audio/sfx/door_key.mp3")
	
	# Other SFX
#	_soundQueuesByName["SFXAudioQueue"] = get_node("SFXAudioQueue")
#	$SFXAudioQueue/SFXStream.bus = &"SFX"
	
	# Music Queue
#	_soundQueuesByName["MusicAudioQueue"] = get_node("MusicAudioQueue")
#	$MusicAudioQueue/MusicStream.bus = &"Music"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_locked_door():
	$SFXAudioQueue/LockedDoor.play()

func play_opened_door():
	$SFXAudioQueue/OpenedDoor.play()

func play_door_key():
	$SFXAudioQueue/DoorKey.play()

func play_music():
	$MusicAudioQueue/MusicStream.play()
#	_soundQueuesByName["MusicAudioQueue"].play_sound()

func stop_music():
	$MusicAudioQueue/MusicStream.stop()
#	_soundQueuesByName["MusicAudioQueue"].stop_sound()

func _enter_tree() -> void:
	# This is the earliest time we can connect to the SceneTree node_added signal in _enter_tree() to catch all the nodes
	get_tree().node_added.connect(_on_node_added)

### TO FIX: Other Instanced Buttons don't have SE ### 
# Function that adds UI SE to instanced buttons
func _on_node_added(node:Node) -> void:
	# We need to wait until this node is ready to connect the signals to our stream players or they will be null
	if not is_ready:
		await ready
		is_ready = true

	if node is Button:
		node.pressed.connect(ui_click.play)
		node.mouse_entered.connect(ui_hover.play)
