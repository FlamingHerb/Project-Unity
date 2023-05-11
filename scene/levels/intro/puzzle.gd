extends Node2D


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

func _on_top_button_1_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_top_button_2_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_top_button_3_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_top_button_4_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_top_button_5_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_top_button_6_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass


func _on_bottom_button_1_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass


func _on_bottom_button_2_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_bottom_button_3_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_bottom_button_4_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_bottom_button_5_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

func _on_bottom_button_6_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		pass

