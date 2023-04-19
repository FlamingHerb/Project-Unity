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
	#_load_settings()
	pass

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
		config.set_value("Window", "window_mode", "window")
	else:
		config.set_value("Window", "window_mode", "fullscreen")
	config.set_value("Window", "screen_res", DisplayServer.window_get_size())
	config.set_value("Window", "vsync", vsync.button_pressed)

	# Save it to a file (overwrite if already exists).
	config.save("user://settings.cfg")

# Loads settings.
func _load_settings():
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://settings.cfg")

	# Creates new default settings, saves it, and then balls from it. Classic.
	if err != OK:
		_default_settings()
		_save_settings()
		return

	master_volume.value = config.get_value("Music", "master_volume")
	bgm_volume.value = config.get_value("Music", "bgm_volume")
	se_volume.value = config.get_value("Music", "se_volume")
	amb_volume.value = config.get_value("Music", "amb_volume")
	text_speed.value = config.get_value("Text", "text_speed")
	auto_speed.value = config.get_value("Text", "auto_speed")

	if config.get_value("Window", "window_mode") == "fullscreen":
		fullscreen_mode.button_pressed = true
	else:
		window_mode.button_pressed = true

	match config.get_value("Window", "screen_res"):
		Vector2i(1280, 720):
			resolution.selected = 0
		Vector2i(1600, 900):
			resolution.selected = 1
		Vector2i(1920, 1080):
			resolution.selected = 2

	vsync.button_pressed = config.get_value("Window", "vsync")

# Reverts to default settings
func _default_settings():
	master_volume.value = 0.5
	bgm_volume.value = 0.5
	se_volume.value = 0.5
	amb_volume.value = 0.5
	text_speed.value = 0.5
	auto_speed.value = 0.5

	window_mode.button_pressed = true
	resolution.selected = 1
	vsync.button_pressed = false

#==============================================================================
# ** Master Volume
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_master_sound_slider_value_changed(value):
	print(linear_to_db(value))
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

#==============================================================================
# ** Music Volume
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_music_slider_value_changed(value):
	print(linear_to_db(value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))

#==============================================================================
# ** SE Volume
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_se_slider_value_changed(value):
	print(linear_to_db(value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))

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
	_save_settings()
	hide()


func _on_restore_default_button_pressed():
	_default_settings()


func _on_draw():
	pass


func _on_hidden():
	pass


func _on_visibility_changed():
	if self.is_visible():
		print("Settings drawn and loaded.")
		_load_settings()
