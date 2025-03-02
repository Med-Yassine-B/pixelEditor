extends Node
var imageSize:=Vector2i(32,32)

@onready var mainNode:Control=get_tree().root.get_node("main")
@onready var bar=mainNode.get_node("VBoxContainer/bar")

@onready var canvas:TextureRect=mainNode.get_node("VBoxContainer/mainWindow/HBoxContainer/view/canvasHolder/canvas")


@onready var imageTexture:ImageTexture=ImageTexture.new()
@onready var image:Image=Image.create(imageSize.x,imageSize.y,true,Image.FORMAT_RGBA8)

@onready var save_button:Button=bar.get_node("HBoxContainer/saveButton")
@onready var load_button:Button=bar.get_node("HBoxContainer/loadButton")

@onready var fileDialog:FileDialog=mainNode.get_node("FileDialog")

func _ready() -> void:
    canvas.texture=ImageTexture.create_from_image(image)

    save_button.pressed.connect(_on_save_pressed)
    load_button.pressed.connect(_on_load_button_pressed)

#==============================================
func _on_save_pressed():
    Editor.image.save_png("res://saves/image.png")
#==============================================
func _on_load_button_pressed():
    print("load")
    fileDialog.popup()
    pass # Replace with function body.
#==============================================		
func update_image():
    canvas.texture=ImageTexture.create_from_image(image)
