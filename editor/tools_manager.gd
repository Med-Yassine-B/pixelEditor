extends Node

enum Tool{
	PENCIL,
	ERASER,
	FILL
}

var selected_tool=Tool.PENCIL
@onready var toolsHolder=get_tree().root.get_node("main/VBoxContainer/mainWindow/HBoxContainer/toolsHolder")

@onready var pencil_button:Button=toolsHolder.get_node("VBoxContainer/GridContainer/pencil")
@onready var fill_button:Button=toolsHolder.get_node("VBoxContainer/GridContainer/fill")
@onready var eraser_button:Button=toolsHolder.get_node("VBoxContainer/GridContainer/eraser")

@onready var fill_tool=FillTool.new()
#==============================================
func _ready() -> void:
	pencil_button.button_down.connect(_on_pencil_pressed)
	fill_button.button_down.connect(_on_fill_pressed)
	eraser_button.button_down.connect(_on_eraser_pressed)
#==============================================
func set_tool(_tool:Tool)->void:
	selected_tool=_tool
#==============================================
func _on_pencil_pressed():
	selected_tool=Tool.PENCIL
#==============================================
func _on_eraser_pressed():
	selected_tool=Tool.ERASER
#==============================================
func _on_fill_pressed():
	selected_tool=Tool.FILL
#==============================================
func get_tool()->Tool:
	return selected_tool
