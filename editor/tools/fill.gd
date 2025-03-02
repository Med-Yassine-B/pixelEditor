extends RefCounted
class_name FillTool


static func fill_area(image:Image,pixelPos:Vector2i,fillColor:Color,oldColor:Color)->void:
	# var equalColors:bool=image.get_pixel(pixelPos.x,pixelPos.y)==fillColor
	if not Rect2(0,0,image.get_width(),image.get_height()).has_point(pixelPos) or image.get_pixelv(pixelPos)==fillColor:
		return
	image.set_pixel(pixelPos.x,pixelPos.y,fillColor)
	var currentPixel:Vector2i
	
	currentPixel=pixelPos+Vector2i.RIGHT
	if Rect2(0,0,image.get_width(),image.get_height()).has_point(currentPixel):
		if image.get_pixel(currentPixel.x,currentPixel.y)==oldColor:
			fill_area(image,currentPixel,fillColor,oldColor)
	
	currentPixel=pixelPos+Vector2i.LEFT
	if Rect2(0,0,image.get_width(),image.get_height()).has_point(currentPixel):
		if image.get_pixel(currentPixel.x,currentPixel.y)==oldColor:
			fill_area(image,currentPixel,fillColor,oldColor)
	
	currentPixel=pixelPos+Vector2i.UP
	if Rect2(0,0,image.get_width(),image.get_height()).has_point(currentPixel):
		if image.get_pixel(currentPixel.x,currentPixel.y)==oldColor:
			fill_area(image,currentPixel,fillColor,oldColor)
	
	currentPixel=pixelPos+Vector2i.DOWN
	if Rect2(0,0,image.get_width(),image.get_height()).has_point(currentPixel):
		if image.get_pixel(currentPixel.x,currentPixel.y)==oldColor:
			fill_area(image,currentPixel,fillColor,oldColor)
