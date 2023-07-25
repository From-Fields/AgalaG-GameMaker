function UIManager(){

}

function DrawButton(pos_x, pos_y, size_x, size_y, text, action = noone, default_color = c_gray, hover_color = c_aqua) {
	var start_btn_x = pos_x - size_x;
	var start_btn_y = pos_y - size_y;

	var start_btn_x2 = pos_x + size_x;
	var start_btn_y2 = pos_y + size_y;

	
	var button_color = default_color, button_size = 0, text_size = 1;

	if (mouse_x >= start_btn_x && mouse_x <= start_btn_x2) && 
		(mouse_y >= start_btn_y && mouse_y <= start_btn_y2) {
		button_color = hover_color;
		button_size = 10;
		text_size = 1.2;
		
		if (action != noone && mouse_check_button_pressed(mb_left)) {
			action();
		}
	}

	draw_set_color(button_color);
	draw_rectangle(start_btn_x - button_size, start_btn_y - button_size, start_btn_x2 + button_size, start_btn_y2 + button_size, false);
	draw_set_color(c_white);
	draw_text_transformed(pos_x, pos_y, text, .2 * text_size, .2 * text_size, 0);
}

function DrawToggleButton(pos_x, pos_y, size_x, size_y, toggle_on, action = noone, default_color = c_white, hover_color = c_gray) {
	var start_btn_x = pos_x - size_x;
	var start_btn_y = pos_y - size_y;

	var start_btn_x2 = pos_x + size_x;
	var start_btn_y2 = pos_y + size_y;

	
	var button_color = default_color, button_size = 0;

	if (mouse_x >= start_btn_x && mouse_x <= start_btn_x2) && 
		(mouse_y >= start_btn_y && mouse_y <= start_btn_y2) {
		button_color = hover_color;
		button_size = 0;
		
		if (mouse_check_button_pressed(mb_left)) {
			if (action != noone)
				action();
			
			toggle_on[@ 0] = !toggle_on[@ 0];
		}
	}

	draw_set_color(button_color);
	draw_rectangle(start_btn_x - button_size, start_btn_y - button_size, start_btn_x2 + button_size, start_btn_y2 + button_size, true);
	
	if (toggle_on[@ 0]) {
		draw_set_color(c_lime);
		draw_rectangle(start_btn_x - button_size + 5, start_btn_y - button_size + 5, start_btn_x2 + button_size - 5, start_btn_y2 + button_size - 5, false);
	}
	
	draw_set_color(c_white);
}

function DrawSlider(pos_x, pos_y, size_x, size_y, position, action = noone, default_color = c_white, pressed_color = c_orange) {
	var start_btn_x = pos_x - size_x * .5;
	var start_btn_y = pos_y - size_y * .5;

	var end_btn_x = pos_x + size_x * .5;
	var end_btn_y = pos_y + size_y * .5;
	
	var slider_size_x = size_x * .05;
	var slider_size_y = size_y * 5;
	
	var start_slider_y = position[@1] - slider_size_y * .5;
	
	var end_slider_x = position[@ 0] + slider_size_x;
	var end_slider_y = position[@ 1] + slider_size_y * .5;
	
	var pressed = false;
	
	if  (mouse_x >= start_btn_x && mouse_x <= end_btn_x) && 
		(mouse_y >= start_slider_y && mouse_y <= end_slider_y) {
		
		if (mouse_check_button(mb_left)) {
			position[@ 0] = clamp(mouse_x, start_btn_x, end_btn_x);
			
			var value = adjustPosition(position, start_btn_x, size_x);
			pressed = true;
			
			if (action != noone)
				action(value);
		}
	}
	
	draw_set_color(c_gray);
	draw_rectangle(start_btn_x, start_btn_y, end_btn_x, end_btn_y, false);
	
	draw_set_color((pressed) ? pressed_color : default_color);
	draw_rectangle(position[@ 0], start_slider_y, end_slider_x, end_slider_y, false);
	
	draw_set_color(c_white);
}

function adjustPosition(position, offset, relativeTo) {
	var value = 0;
	
	for (var i = 1; i <= 10; i += 1) {
		//show_debug_message("x: " + string(position[@ 0] - offset) + "\tsize: " + string(relativeTo * (i/10)))
		if (position[@ 0] - offset >= relativeTo * (i/10) && position[@ 0] - offset < relativeTo * ((i + 1)/10)) {
			value = i;
			//position[@ 0] = relativeTo * (i/10) + offset;
			
			break;
		}
	}
	
	//show_debug_message(value);
	return value;
	
}