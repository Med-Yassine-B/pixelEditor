extends Control

var imageSize:=Vector2(32,32)
enum tools{
	PENCIL,
	ERASER,
	FILL
}
@onready var canvas:TextureRect=$VBoxContainer/mainWindow/HBoxContainer/view/canvasHolder/canvas
@onready var gridBackground:TextureRect=$VBoxContainer/mainWindow/HBoxContainer/view/canvasHolder/backgroundRect
@onready var canvasHolder:Control=$VBoxContainer/mainWindow/HBoxContainer/view/canvasHolder

@onready var colorPicker:ColorPicker=$VBoxContainer/mainWindow/HBoxContainer/toolsHolder/Popup/ColorPicker
@onready var colorIndicator:ColorRect=$VBoxContainer/mainWindow/HBoxContainer/toolsHolder/VBoxContainer/colorChanging/ColorRect
@onready var fileDialog:FileDialog=$FileDialog

@onready var imageTexture:ImageTexture=ImageTexture.new()
@onready var image:Image=Image.create(imageSize.x,imageSize.y,true,Image.FORMAT_RGBA8)
var color:Color
var tool=tools.PENCIL
var drawing=false
# Called when the node enters the scene tree for the first time.
func _ready():
	print(canvasHolder.custom_minimum_size ,":)")
	canvasHolder.custom_minimum_size=Vector2(500,500)
	gridBackground.texture=ImageTexture.create_from_image(Image.create(imageSize.x,imageSize.y,true,Image.FORMAT_RGBA8))
	
	canvas.texture=ImageTexture.create_from_image(image)
	

	
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		drawing=event.is_pressed()
		if canvas.get_rect().has_point(event.position-canvas.global_position):
			var pixelPos:=Vector2()
			pixelPos=(event.position-canvas.global_position)/canvas.get_rect().size*imageSize
			pixelPos.floor()
			
			if tool==tools.PENCIL:
				image.set_pixel(pixelPos.x,pixelPos.y,color)
			elif tool==tools.ERASER:
				image.set_pixel(pixelPos.x,pixelPos.y,Color(0,0,0,0))
			elif tool==tools.FILL and event.pressed:
				fill_area(image,pixelPos,color,image.get_pixel(pixelPos.x,pixelPos.y))
			update_image()
			
	elif event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_RIGHT:
		if canvas.get_rect().has_point(event.position-canvas.global_position):
			var pixelPos:=Vector2()
			pixelPos=(event.position-canvas.global_position)/canvas.get_rect().size*imageSize
			pixelPos.floor()
			color=image.get_pixel(pixelPos.x,pixelPos.y)
			colorIndicator.color=color
			colorPicker.color=color
			
	if event is InputEventMouseMotion and drawing:
		if canvas.get_rect().has_point(event.position-canvas.global_position):
			var pixelPos:=Vector2()
			pixelPos=(event.position-canvas.global_position)/canvas.get_rect().size*imageSize
			pixelPos.floor()
			
			if tool==tools.PENCIL:
				image.set_pixel(pixelPos.x,pixelPos.y,color)
			elif tool==tools.ERASER:
				image.set_pixel(pixelPos.x,pixelPos.y,Color(0,0,0,0))
			update_image()
			pass
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func update_image():
	canvas.texture=ImageTexture.create_from_image(image)

func fill_area(image:Image,pixelPos:Vector2,fillColor:Color,oldColor:Color)->void:
	var equalColors:bool=image.get_pixel(pixelPos.x,pixelPos.y)==fillColor
	if not Rect2(0,0,image.get_width(),image.get_height()).has_point(pixelPos) or image.get_pixelv(pixelPos)==fillColor:
		return
	image.set_pixel(pixelPos.x,pixelPos.y,fillColor)
	var currentPixel:Vector2
	
	currentPixel=pixelPos+Vector2.RIGHT
	if Rect2(0,0,image.get_width(),image.get_height()).has_point(currentPixel):
		if image.get_pixel(currentPixel.x,currentPixel.y)==oldColor:
			fill_area(image,currentPixel,fillColor,oldColor)
	
	currentPixel=pixelPos+Vector2.LEFT
	if Rect2(0,0,image.get_width(),image.get_height()).has_point(currentPixel):
		if image.get_pixel(currentPixel.x,currentPixel.y)==oldColor:
			fill_area(image,currentPixel,fillColor,oldColor)
	
	currentPixel=pixelPos+Vector2.UP
	if Rect2(0,0,image.get_width(),image.get_height()).has_point(currentPixel):
		if image.get_pixel(currentPixel.x,currentPixel.y)==oldColor:
			fill_area(image,currentPixel,fillColor,oldColor)
	
	currentPixel=pixelPos+Vector2.DOWN
	if Rect2(0,0,image.get_width(),image.get_height()).has_point(currentPixel):
		if image.get_pixel(currentPixel.x,currentPixel.y)==oldColor:
			fill_area(image,currentPixel,fillColor,oldColor)



func _on_button_pressed():
	image.save_png("res://saves/image.png")
	pass # Replace with function body.


func _on_colorChange_button_pressed():
	$VBoxContainer/mainWindow/HBoxContainer/toolsHolder/Popup.popup()
	pass # Replace with function body.


func _on_color_picker_color_changed(color):
	self.color=color
	colorIndicator.color=color
	pass # Replace with function body.


func _on_pencil_pressed():
	tool=tools.PENCIL
	pass # Replace with function body.


func _on_eraser_pressed():
	tool=tools.ERASER
	pass # Replace with function body.


func _on_fill_pressed():
	tool=tools.FILL
	pass # Replace with function body.

var maxImageSize=256
func _on_file_dialog_file_selected(path):
	var loadedImage=Image.load_from_file(path)
	if loadedImage.get_size().x>maxImageSize or loadedImage.get_size().y>maxImageSize:
		print("too big")
		return
	image=loadedImage
	imageSize=image.get_size()
	update_image()
	#load an image
	pass # Replace with function body.


func _on_load_button_pressed():
	fileDialog.popup()
	pass # Replace with function body.
