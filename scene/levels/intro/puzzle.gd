extends Node2D

var letter = [0, 0, 0, 0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _mouse_click_detection(event:InputEvent):
	return event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT

func _on_answer_button_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		print("sex")

func add_num(index: int):
	match letter[index]:
		2:
			letter[index] = 0
		_:
			letter[index] += 1
	print("Add " + str(index) + ": " + str(letter[index]))

func sub_num(index: int):
	match letter[index]:
		0:
			letter[index] = 2
		_:
			letter[index] -= 1
	print("Sub " + str(index) + ": " + str(letter[index]))

func _on_top_button_1_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(0)

func _on_top_button_2_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(1)

func _on_top_button_3_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(2)

func _on_top_button_4_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(3)

func _on_top_button_5_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(4)

func _on_top_button_6_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(5)

func _on_bottom_button_1_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(0)

func _on_bottom_button_2_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(1)

func _on_bottom_button_3_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(2)

func _on_bottom_button_4_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(3)

func _on_bottom_button_5_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(4)

func _on_bottom_button_6_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(5)

