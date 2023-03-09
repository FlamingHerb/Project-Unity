extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$/root/MainMenu/About/About_Content.bbcode_text = "Project Unity is a captivating mystery short story that immerses the player in a thrilling and immersive gameplay experience. Set in a dark and gritty fictional Philippines, the game offers players the chance to step into the role of a tenacious detective who is determined to make a name for himself in a city rife with corruption and violence. Through its intricate plotline, Project Unity aims to shed light on the complex and challenging state of the Philippine criminal justice system, highlighting the difficulties faced by those who are working to combat crime and promote justice.

One of the most exciting features of Project Unity is its engaging point-and-click gameplay, which allows players to explore a fully-realized world and interact with a wide variety of characters and objects. From searching for clues to interrogating suspects, every decision made by the player has real consequences for the outcome of the game. Furthermore, the game's rich storyline offers players a compelling narrative that is both thought-provoking and emotionally engaging. As players delve deeper into the game's mysteries, they will encounter a diverse cast of characters and confront a range of challenging ethical dilemmas.

Overall, Project Unity is a masterful work of interactive storytelling that seamlessly blends mystery, adventure, and social commentary. By immersing players in the dark and dangerous world of the fictional Philippines, the game offers a unique and thought-provoking perspective on the contemporary state of the Philippine criminal justice system. With its engaging gameplay, rich storyline, and immersive setting, Project Unity is a must-play for anyone who loves a good mystery or wants to explore the complex issues facing modern society."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	hide()
