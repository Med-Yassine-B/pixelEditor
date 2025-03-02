extends Control

var imageSize:=Vector2i(32,32)
@onready var gridBackground:TextureRect=$VBoxContainer/mainWindow/HBoxContainer/view/canvasHolder/backgroundRect
@onready var canvasHolder:Control=$VBoxContainer/mainWindow/HBoxContainer/view/canvasHolder

@onready var colorPicker:ColorPicker=$VBoxContainer/mainWindow/HBoxContainer/toolsHolder/Popup/ColorPicker
@onready var colorIndicator:ColorRect=$VBoxContainer/mainWindow/HBoxContainer/toolsHolder/VBoxContainer/colorChanging/ColorRect


var color:Color

var drawing=false
#==============================================
func _ready():
	# print(canvasHolder.custom_minimum_size ,":)")
	canvasHolder.custom_minimum_size=Vector2(500,500)
	gridBackground.texture=ImageTexture.create_from_image(Image.create(imageSize.x,imageSize.y,true,Image.FORMAT_RGBA8))
	
#==============================================
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			drawing=event.is_pressed()
			if Editor.canvas.get_rect().has_point(event.position-Editor.canvas.global_position):
				var pixelPos=get_pixel_pos(event.position)
				
				if ToolsManager.get_tool()==ToolsManager.Tool.PENCIL:
					Editor.image.set_pixel(pixelPos.x,pixelPos.y,color)
				elif ToolsManager.get_tool()==ToolsManager.Tool.ERASER:
					Editor.image.set_pixel(pixelPos.x,pixelPos.y,Color(0,0,0,0))
				elif ToolsManager.get_tool()==ToolsManager.Tool.FILL and event.pressed:
					
					FillTool.fill_area(Editor.image,pixelPos,color,Editor.image.get_pixel(pixelPos.x,pixelPos.y))
					pass
					
					
					# fill_area(image,pixelPos,color,image.get_pixel(pixelPos.x,pixelPos.y))
				Editor.update_image()
				
		elif event.button_index==MOUSE_BUTTON_RIGHT:
			if Editor.canvas.get_rect().has_point(event.position-Editor.canvas.global_position):
				pick_color(event.position)			
	elif event is InputEventMouseMotion and drawing:
		if Editor.canvas.get_rect().has_point(event.position-Editor.canvas.global_position):
			var pixelPos=get_pixel_pos(event.position)
			
			if ToolsManager.get_tool()==ToolsManager.Tool.PENCIL:
				Editor.image.set_pixel(pixelPos.x,pixelPos.y,color)
			elif ToolsManager.get_tool()==ToolsManager.Tool.ERASER:
				Editor.image.set_pixel(pixelPos.x,pixelPos.y,Color(0,0,0,0))
			Editor.update_image()
			pass
#==============================================
func get_pixel_pos(click_pos:Vector2)->Vector2i:
	var pixelPos:Vector2i=(click_pos-Editor.canvas.global_position)/Editor.canvas.get_rect().size*Vector2(imageSize)
	return pixelPos
	
#==============================================
func pick_color(click_pos:Vector2)->void:
	var pixelPos=get_pixel_pos(click_pos)

	color=Editor.image.get_pixel(pixelPos.x,pixelPos.y)
	colorIndicator.color=color
	colorPicker.color=color
#==============================================

#==============================================
func _on_colorChange_button_pressed():
	$VBoxContainer/mainWindow/HBoxContainer/toolsHolder/Popup.popup()
#==============================================
func _on_color_picker_color_changed(color:Color):
	self.color=color
	colorIndicator.color=color
#==============================================
var maxImageSize=256
func _on_file_dialog_file_selected(path):
	var loadedImage=Image.load_from_file(path)
	if loadedImage.get_size().x>maxImageSize or loadedImage.get_size().y>maxImageSize:
		print("too big")
		return
	Editor.image=loadedImage
	imageSize=Editor.image.get_size()
	Editor.update_image()
	#load an image
	pass # Replace with function body.
