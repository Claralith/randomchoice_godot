extends Control

@onready var item_to_add = $ItemToAdd
@onready var items = $Items
@onready var button = $Button
@onready var random_choice_button = $RandomChoiceButton
@onready var selected_random_choice_text = $RandomChoiceText/SelectedRandomChoiceText
var focus

func add_item():
	var text = item_to_add.text.strip_edges()
	if text != "":
		items.add_item(text)
		item_to_add.text = ""

var rng = RandomNumberGenerator.new()
func get_random_choice():
	if items.item_count >= 2:
		var randomNumber = rng.randi_range(0, items.item_count-1)
		selected_random_choice_text.text = items.get_item_text(randomNumber)
		print(randomNumber)
		print(selected_random_choice_text.text)
	#if items.item_count == 1:
		##selected_random_choice_text = items.get_children()[0]
		#print(items.get_index(1))

func _input(event):
	if event.is_action_pressed("AddItem"):
		if focus == item_to_add:
			add_item()
			#print(items)
			item_to_add.grab_focus()

func _on_focus_changed(control: Control) -> void:
	focus = control
	#print(focus == item_to_add)

func _ready() -> void:
	button.pressed.connect(add_item)
	random_choice_button.pressed.connect(get_random_choice)
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
