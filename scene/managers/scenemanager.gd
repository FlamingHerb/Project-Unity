extends Node

## The scene manager of the game.
##
## Checks and loads up scenes that the player goes to.
##
## @tutorial:            https://the/tutorial1/url.com
## @tutorial(Tutorial2): https://the/tutorial2/url.com

##===============================================
## Variables
##===============================================

var level_path = "res://scene/levels/"
var current_scene = null

##===============================================
## Godot Processing functions
##===============================================

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

##===============================================
## Scene-related functions
##===============================================

## Is called when the game is in debug mode.
## Paired with OS.is_debug_build()
func debug_test():
	GamePauseUI.toggle_ui(true)
	DialogueScreen.toggle_ui(true)

## Goes to the following scene regardless of path.
func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)

## Goes to the scenes that are in the level folder.
func goto_level_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	var path_of_level = level_path + path
	call_deferred("_deferred_goto_scene", path_of_level)

## Frees current scene and jumps to the next.
func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
