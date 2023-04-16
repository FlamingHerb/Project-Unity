extends Node

# array for Music that requires a Queue
@onready var _soundQueuesByName = {}

@onready var ui_click := $BtnAudioQueue/UiClick
@onready var ui_hover := $BtnAudioQueue/UiHover

var is_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Buttons SFX
	ui_click.stream = load("res://assets/audio/sfx/ui_click.mp3")
	ui_hover.stream = load("res://assets/audio/sfx/ui_hover.mp3")
	ui_click.bus = &"SFX"
	ui_hover.bus = &"SFX"
	_soundQueuesByName["BtnAudioQueue"] = get_node("BtnAudioQueue") # not used
	#_get_configuration_warnings()
	# Music Queue
	$MusicAudioQueue/MusicStream.bus = &"Music"
	_soundQueuesByName["MusicAudioQueue"] = get_node("MusicAudioQueue")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

'''
func play_ui():
	_soundQueuesByName["BtnAudioQueue"].play_sound()
'''

func play_music():
	_soundQueuesByName["MusicAudioQueue"].play_sound()

func stop_music():
	_soundQueuesByName["MusicAudioQueue"].stop_sound()

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
