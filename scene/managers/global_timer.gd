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

func _text_time_update(seconds: int):
	var minutes = time_needed / 60
	var secondss = time_needed % 60
	var str_elapsed = "%02d : %02d" % [minutes, secondss]
	the_timer_text.text = str_elapsed

## Set time by the seconds.
func ready_time(seconds: int):
	time_needed = seconds

	_text_time_update(time_needed)

	the_timer.start()

func _on_timer_timeout():
	time_needed -= 1

	_text_time_update(time_needed)

	if !time_needed:
		global_timer_timeout.emit()
		the_timer.stop()

