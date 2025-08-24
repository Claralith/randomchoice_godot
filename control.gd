extends Control

@onready var item_to_add = $ItemToAdd
@onready var items = $Items
@onready var button = $Button
@onready var random_choice_button = $RandomChoiceButton
@onready var selected_random_choice_text = $RandomChoiceText/SelectedRandomChoiceText
@onready var delete_item_button = $DeleteItemButton
var focus
var selected_list_item

func add_item():
	var text = item_to_add.text.strip_edges()
	if text != "":
		items.add_item(text)
		item_to_add.text = ""

func delete_item():
	print(items.get_selected_items())
	for item in items.get_selected_items():
		items.remove_item(item)

var rng = RandomNumberGenerator.new()
func get_random_choice():
	if items.item_count >= 2:
		var randomNumber = rng.randi_range(0, items.item_count-1)
		selected_random_choice_text.text = items.get_item_text(randomNumber)
	if items.item_count == 1:
		selected_random_choice_text.text = items.get_item_text(0)

func _input(event):
	if event.is_action_pressed("AddItem"):
		if focus == item_to_add:
			add_item()
			item_to_add.grab_focus()
	#if event.is_action_pressed("Delete"):
		#items.remove_item(selected_list_item)

func _on_focus_changed(control: Control) -> void:
	focus = control
	#print(focus == item_to_add)

func _ready() -> void:
	button.pressed.connect(add_item)
	random_choice_button.pressed.connect(get_random_choice)
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	delete_item_button.pressed.connect(delete_item)
	
