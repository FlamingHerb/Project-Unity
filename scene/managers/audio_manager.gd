extends Node

@onready var _soundQueuesByName = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	_soundQueuesByName["ClickAudioQueue"] = get_node("ClickAudioQueue")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_click():
	_soundQueuesByName["ClickAudioQueue"].play_sound()
