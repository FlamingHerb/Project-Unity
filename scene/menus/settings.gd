extends Control

@onready var master_volume = $MusicAndDisplayGroup/MasterSoundSlider
@onready var bgm_volume = $MusicAndDisplayGroup/MusicSlider
@onready var se_volume = $MusicAndDisplayGroup/SESlider
@onready var amb_volume = $MusicAndDisplayGroup/AmbienceSlider
@onready var text_speed = $MusicAndDisplayGroup/TextSpeedSlider
@onready var auto_speed = $MusicAndDisplayGroup/AutoSpeedSlider
@onready var window_mode = $DisplayGroup/WindowModeBoxes/WindowBox
@onready var fullscreen_mode = $DisplayGroup/WindowModeBoxes/FullscreenBox
@onready var resolution = $DisplayGroup/ResOptions
@onready var vsync = $DisplayGroup/VSync

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Saves settings.
func _save_settings():
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("Music", "master_volume", master_volume.value)
	config.set_value("Music", "bgm_volume", bgm_volume.value)
	config.set_value("Music", "se_volume", se_volume.value)
	config.set_value("Music", "amb_volume", amb_volume.value)
	config.set_value("Text", "text_speed", text_speed.value)
	config.set_value("Text", "auto_speed", auto_speed.value)
	if window_mode.button_pressed == true:
		config.set_value("Window", "window_mode", "fullscreen")
	else:
		config.set_value("Window", "window_mode", "window")
	config.set_value("Window", "screen_res", DisplayServer.window_get_size())
	config.set_value("Window", "vsync", vsync.button_pressed)

	# Save it to a file (overwrite if already exists).
	config.save("user://settings.cfg")

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

func _on_window_box_toggled(_button_pressed):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	$DisplayGroup/ResOptions.disabled = false


func _on_fullscreen_box_toggled(_button_pressed):
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


func _on_restore_default_button_pressed():
	_save_settings()


func _on_draw():
	print("Settings drawn.")


func _on_hidden():
	print("Settings hidden.")
