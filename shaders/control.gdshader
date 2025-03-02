shader_type canvas_item;

void fragment() {
    // Get the UV coordinates
    //vec2 uv = U;
    
    // Convert UV to pixel position in texture
    vec2 pixel_pos = UV/TEXTURE_PIXEL_SIZE;
	
	if((int(pixel_pos.x)+int(pixel_pos.y))%2==0){
		COLOR=vec4(1,1,1,1);
	}else{
		COLOR=vec4(0.5,0.5,0.5,1);
	}

    // Use pixel_pos in your shader logic
    //COLOR = texture(TEXTURE, uv);
}
