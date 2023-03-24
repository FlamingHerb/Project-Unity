extends Control
var story_log = ""

@onready var rich_text_label = get_node("TextLog/TextLogCanvasLayer/MarginContainer/MarginContainer/RichTextLabel")

# Function to update the story log and the RichTextLabel
func update_story_log(new_line):
	# Append the new story line to the text log
	story_log += new_line + "\n"
	# Update the RichTextLabel to display the new text log
	rich_text_label.bbcode_text = story_log
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# Character dialogue
	update_story_log("The mystery begins...\n")
	update_story_log("You find yourself standing in front of a grand mansion on a stormy night.")
	update_story_log("As you step inside, you hear a blood-curdling scream coming from upstairs.\n")
	update_story_log("You: What was that? Did you hear it?")
	update_story_log("Character 1: Yeah, sounded like it came from upstairs. Should we go check it out?\n")
	update_story_log("You rush up to investigate, and find the body of the mansion's owner lying in a pool of blood.\n")
	update_story_log("You: Oh my god! Is he...?")
	update_story_log("Character 1: Yeah, he's dead. Who could have done this?\n")
	update_story_log("Your only hope is to find clues, solve puzzles, and unmask the killer before it's too late.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
