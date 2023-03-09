extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#==============================================================================
# ** Master Volume
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_master_sound_slider_value_changed(value):
	print(linear_to_db(value))
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


#==============================================================================
# ** Fullscreen
#------------------------------------------------------------------------------
#	TODO: Rework code
#==============================================================================

func _on_window_box_toggled(button_pressed):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	$DisplayGroup/ResOptions.disabled = false


func _on_fullscreen_box_toggled(button_pressed):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$DisplayGroup/ResOptions.disabled = true


#==============================================================================
# ** Resolution
#------------------------------------------------------------------------------
#	1 - 1280 x 720
#	2 - 1600 x 900
#	3 - 1920 x 1080
#==============================================================================

func _on_res_options_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1280, 720))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1920, 1080))

func _on_vsync_button_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_backbutton_pressed():
	hide()
