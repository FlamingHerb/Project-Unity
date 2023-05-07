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
			var dup = audio_stream_player.duplicate()
			if dup is AudioStreamPlayer:
				add_child(dup)
				_audio_stream_players.append(dup)

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
