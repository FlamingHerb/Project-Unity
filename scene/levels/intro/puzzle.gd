extends Node2D

signal mystery_solved

var letter = [0, 0, 0, 0, 0, 0]

var let_dic_1 = ["d","t","s","c","w"] # 0
var let_dic_2 = ["y","g","e","n","d"] # 2
var let_dic_3 = ["f","a","t","c","m"] # 4
var let_dic_4 = ["g","i","x","v","r"] # 1
var let_dic_5 = ["h","w","o","s","r"] # 3
var let_dic_6 = ["e","b","v","x","t"] # 0

var letter_length = len(let_dic_1) - 1

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
	return GlobalDatabase.is_mouse_clicked(event)

func _on_answer_button_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if _mouse_click_detection(event):
		if letter == [0, 2, 4, 1, 3, 0]:
			AudioManager.play_sound("puzzle_button")
			DialogueScreen.init_dialogue("prologue_dialogue", "PS0")
			await DialogueScreen.dialogue_part_finished
			await DialogueScreen.dialogue_part_finished
			Inventory.add_item("Invitation")
			await DialogueScreen.dialogue_all_finished
			GlobalDatabase.toggle_switch("puzzle_solved", true)
			mystery_solved.emit()
		else:
			print("Yeah, kinda wrong buddy.")

func add_num(index: int):
	AudioManager.play_sound("puzzle_button")
	match letter[index]:
		letter_length:
			letter[index] = 0
		_:
			letter[index] += 1
	print("Add " + str(index) + ": " + str(letter[index]))

func sub_num(index: int):
	AudioManager.play_sound("puzzle_button")
	match letter[index]:
		0:
			letter[index] = letter_length
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
