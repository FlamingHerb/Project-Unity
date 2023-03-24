extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$/root/MainMenu/Help/Help_Content.bbcode_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas finibus semper quam, vitae consequat risus sodales non. Sed eu purus auctor, bibendum elit non, suscipit felis. Aenean eget dui quis libero dapibus vestibulum. Nam ac risus tincidunt, ullamcorper velit ac, efficitur justo. Morbi malesuada neque sit amet nulla rutrum lacinia. Nulla facilisi. Duis et mi at turpis bibendum pulvinar. Quisque auctor felis in sapien congue, id vestibulum arcu convallis. Vivamus at velit nisl. Integer gravida nulla eget turpis luctus, eu volutpat eros lobortis. Maecenas finibus lectus at magna ultrices malesuada. Duis mollis, arcu eu euismod auctor, mi dui aliquet felis, vel fermentum est mi at nisl. Nulla facilisi. Sed vel libero quis metus hendrerit mattis. Curabitur posuere quam eu turpis fringilla congue."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_button_pressed():
	hide()
