@tool
extends Node

@export var count = 2

var _next = 0
var _audio_stream_players : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var child = get_child(0)
	if child is AudioStreamPlayer:
		var audio_stream_player = child as AudioStreamPlayer
		_audio_stream_players.append(audio_stream_player)
		for i in range(count):
			var duplicate = audio_stream_player.duplicate()
			if duplicate is AudioStreamPlayer:
				add_child(duplicate)
				_audio_stream_players.append(duplicate)

# TO FIX: Doesn't show
func _get_configuration_warning() -> String:
	var warning := ""
	if get_child_count() == 0:
		warning =  "No children found. Expected one AudioStreamPLayer child."
	if not get_child(0) is AudioStreamPlayer:
		warning = "Expected first child to be an AudioStreamPlayer"
	return warning


func play_sound() -> void:
	if !_audio_stream_players[_next].playing:
		_audio_stream_players[_next].play()
		_next += 1
		_next %= count

func stop_sound() -> void:
	if _audio_stream_players[_next].playing:
		_audio_stream_players[_next].stop()
		_next += 1
		_next %= count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
