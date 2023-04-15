extends Node

# array for Music that requires a Queue
@onready var _soundQueuesByName = {}

@onready var nUiClick := $BtnAudioQueue/UiClick
@onready var nUiHover := $BtnAudioQueue/UiHover

var is_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_soundQueuesByName["BtnAudioQueue"] = get_node("BtnAudioQueue")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_ui():
	_soundQueuesByName["BtnAudioQueue"].play_sound()

func _enter_tree() -> void:
	# This is the earliest time we can connect to the SceneTree node_added signal in _enter_tree() to catch all the nodes
	get_tree().node_added.connect(_on_node_added)

# Function that adds UI SFX to instanced buttons
func _on_node_added(node:Node) -> void:
	# We need to wait until this node is ready to connect the signals to our stream players or they will be null
	if not is_ready:
		await ready
		is_ready = true

	if node is Button:
		node.pressed.connect(nUiClick.play)
		node.mouse_entered.connect(nUiHover.play)
