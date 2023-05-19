extends Node

signal global_timer_timeout

var time_needed = 0
@onready var the_timer = $TimeLayer/Timer
@onready var the_timer_text = $TimeLayer/TimerText

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _text_time_update():
	var minutes = time_needed / 60
	var seconds = time_needed % 60
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	the_timer_text.text = str_elapsed
	if OS.is_debug_build():
		print(str_elapsed)

## Set time by the seconds.
func ready_time(seconds: int):
	time_needed = seconds

	_text_time_update()

	the_timer.start()

func stop_time():
	the_timer.stop()

func _on_timer_timeout():
	time_needed -= 1

	_text_time_update()

	if !time_needed:
		print("Time ended.")
		global_timer_timeout.emit()
		the_timer.stop()

