extends Control

## The pause layer of the game.
##
## This is where the pause menu components are stored.
## The following are the inventory, the text log and
## the pause menu.
##
## @tutorial:            https://the/tutorial1/url.com
## @tutorial(Tutorial2): https://the/tutorial2/url.com

##===============================================
## Variables
##===============================================

@onready var textlog = $PauseCanvasLayer/TextLog
@onready var textlog_text = $PauseCanvasLayer/TextLog/TextLogText #FIXME: WHY


##===============================================
## Godot Processing functions
##===============================================

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

##===============================================
## UI-related functions
##===============================================

## Toggles UI of GamePauseUI.
func toggle_ui(value):
	if value:
		$PauseCanvasLayer.show()
	else:
		$PauseCanvasLayer.hide()

##===============================================
## Other related functions
##===============================================

func _on_pause_button_pressed():
	GlobalDatabase.get_save_screenshot()
	get_tree().paused = true
	$PauseCanvasLayer/PauseMenu.show()


func _on_inventory_button_pressed():
	get_tree().paused = true
	$PauseCanvasLayer/InventoryMenu.show()


func _on_text_log_button_pressed():
	get_tree().paused = true
	textlog.show()


func _on_text_log_close_button_pressed():
	get_tree().paused = false
	textlog.hide()

func clear_textlog():
	textlog_text.clear()

func dialogue_running():
	$PauseCanvasLayer/PauseMenu/GridContainer/SaveButton.disabled = true
	$PauseCanvasLayer/InventoryLabel.hide()
	$PauseCanvasLayer/InventoryButton.hide()

func dialogue_done():
	$PauseCanvasLayer/PauseMenu/GridContainer/SaveButton.disabled = false
	$PauseCanvasLayer/InventoryLabel.show()
	$PauseCanvasLayer/InventoryButton.show()