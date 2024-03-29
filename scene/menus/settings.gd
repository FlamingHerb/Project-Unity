extends Control

@onready var master_volume = $MusicAndDisplayGroup/MasterSoundSlider
@onready var bgm_volume = $MusicAndDisplayGroup/MusicSlider
@onready var se_volume = $MusicAndDisplayGroup/SESlider
@onready var amb_volume = $MusicAndDisplayGroup/AmbienceSlider
@onready var text_speed = $MusicAndDisplayGroup/TextSpeedSlider
@onready var auto_speed = $MusicAndDisplayGroup/AutoSpeedSlider
@onready var window_mode = $DisplayGroup/WindowOption
@onready var resolution = $DisplayGroup/ResOptions
@onready var vsync = $DisplayGroup/VSync

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Settings loaded")
	load_settings()

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
	config.set_value("Window", "window_mode", window_mode.button_pressed)
	config.set_value("Window", "screen_res", resolution.selected)
	config.set_value("Window", "vsync", vsync.button_pressed)

	# Save it to a file (overwrite if already exists).
	config.save("user://settings.cfg")

# Loads settings.
func load_settings():
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

	if config.get_value("Window", "window_mode"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		resolution.disabled = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		resolution.disabled = false

	window_mode.button_pressed = config.get_value("Window", "window_mode")

	match config.get_value("Window", "screen_res"):
		0:
			resolution.selected = 0
			DisplayServer.window_set_size(Vector2i(1280, 720))
		1:
			resolution.selected = 1
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			resolution.selected = 2
			DisplayServer.window_set_size(Vector2i(1920, 1080))

	vsync.button_pressed = config.get_value("Window", "vsync")

# Reverts to default settings
func _default_settings():
	master_volume.value = 0.75
	bgm_volume.value = 0.75
	se_volume.value = 0.75
	amb_volume.value = 0.75
	text_speed.value = 1
	auto_speed.value = 1

	window_mode.button_pressed = true
	resolution.selected = 1
	vsync.button_pressed = false

#==============================================================================
# ** Master Volume
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_master_sound_slider_value_changed(value):
	#print(linear_to_db(value))
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

#==============================================================================
# ** Music Volume
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_music_slider_value_changed(value):
	#print(linear_to_db(value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))

#==============================================================================
# ** SE Volume
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_se_slider_value_changed(value):
	#print(linear_to_db(value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))

#==============================================================================
# ** Ambience Volume
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_ambience_slider_value_changed(value):
	print(linear_to_db(value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambience"),linear_to_db(value))

#==============================================================================
# ** Text Settings
#------------------------------------------------------------------------------
#  
#==============================================================================

func _on_text_speed_slider_value_changed(value:float):
	DialogueScreen.text_speed_settings = value

func _on_auto_speed_slider_value_changed(value:float):
	DialogueScreen.auto_speed_settings = value

#==============================================================================
# ** Fullscreen
#------------------------------------------------------------------------------
#	TODO: Rework code
#==============================================================================

func _on_window_option_toggled(button_pressed:bool):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		resolution.disabled = true
	else:
		var selected_item_name = resolution.get_item_text(resolution.selected)
		match selected_item_name:
			"1280x720":
				DisplayServer.window_set_size(Vector2i(1280, 720))
			"1600x900":
				DisplayServer.window_set_size(Vector2i(1600, 900))
			"1920x1080":
				DisplayServer.window_set_size(Vector2i(1920, 1080))
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		resolution.disabled = false

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
		load_settings()
