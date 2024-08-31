extends Node2D

func _ready():
	# Create a SubViewport for pixel art
	var sub_viewport = SubViewport.new()
	sub_viewport.size = Vector2(32, 32)  # Set to your pixel art dimensions
	
	# Disable filtering and ensure sharp pixels
	#sub_viewport.texture_filter = SubViewport.TEXTURE_FILTER_NEAREST
	
	# Add the SubViewport as a child
	add_child(sub_viewport)
	
	# Create a Node2D (or CanvasLayer) inside the SubViewport to do the drawing
	var draw_node = Node2D.new()
	sub_viewport.add_child(draw_node)
	
	# Connect the drawing to the _draw() function in the draw_node
	#draw_node.connect("draw", self, "_draw")

	# Trigger drawing inside the SubViewport
	#draw_node.update()
	
	# Save the pixel art to a PNG file after the drawing
	#await(get_tree(), "idle_frame")  # Ensure the drawing happens before saving
	var image = sub_viewport.get_texture().get_image()
	image.save_png("res://pixel_art.png")

func _draw():
	# Pixel art drawing, make sure it's drawn inside the SubViewport
	draw_rect(Rect2(0, 0, 32, 32), Color.BLACK)  # Background
	draw_rect(Rect2(4, 4, 8, 8), Color.RED)      # A small red square pixel art style
	draw_rect(Rect2(20, 20, 4, 4), Color.BLUE)   # A small blue square
