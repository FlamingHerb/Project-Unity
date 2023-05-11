extends Node2D

signal mystery_solved

var letter = [0, 0, 0, 0, 0, 0]

var let_dic_1 = ["a","b","c"]
var let_dic_2 = ["a","b","c"]
var let_dic_3 = ["a","b","c"]
var let_dic_4 = ["a","b","c"]
var let_dic_5 = ["a","b","c"]
var let_dic_6 = ["a","b","c"]

@onready var letter_1 = $TextLabel1
@onready var letter_2 = $TextLabel2
@onready var letter_3 = $TextLabel3
@onready var letter_4 = $TextLabel4
@onready var letter_5 = $TextLabel5
@onready var letter_6 = $TextLabel6


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
		if letter == [1, 1, 1, 1, 1, 1]:
			GlobalDatabase.toggle_switch("puzzle_solved", true)
			mystery_solved.emit()
		else:
			print("Yeah, kinda wrong buddy.")

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

func _change_text(index: int):
	match index:
		0:
			letter_1.text = let_dic_1[letter[index]]
		1:
			letter_2.text = let_dic_2[letter[index]]
		2:
			letter_3.text = let_dic_3[letter[index]]
		3:
			letter_4.text = let_dic_4[letter[index]]
		4:
			letter_5.text = let_dic_5[letter[index]]
		5:
			letter_6.text = let_dic_6[letter[index]]

func _on_top_button_1_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(0)
	_change_text(0)

func _on_top_button_2_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(1)
	_change_text(1)

func _on_top_button_3_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(2)
	_change_text(2)

func _on_top_button_4_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(3)
	_change_text(3)

func _on_top_button_5_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(4)
	_change_text(4)

func _on_top_button_6_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		sub_num(5)
	_change_text(5)

# Bottom ones

func _on_bottom_button_1_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(0)
	_change_text(0)

func _on_bottom_button_2_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(1)
	_change_text(1)

func _on_bottom_button_3_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(2)
	_change_text(2)

func _on_bottom_button_4_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(3)
	_change_text(3)


func _on_bottom_button_5_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(4)
	_change_text(4)

func _on_bottom_button_6_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		add_num(5)
	_change_text(5)