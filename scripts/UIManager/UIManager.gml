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