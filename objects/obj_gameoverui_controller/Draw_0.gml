if (!show) exit;

draw_set_alpha(0.4);
draw_rectangle_colour(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
	
	
draw_set_alpha(1);
draw_set_font(default_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed_color(room_width/2, room_height/6, "Game Over", 1, 1, 0, c_fuchsia, c_fuchsia, c_fuchsia, c_fuchsia, 1);


draw_text_transformed(room_width/2, room_height/2 - 50, "Score", .3, .3, 0);
draw_text_transformed_color(room_width/2, room_height/2, string(obj_levelController._score), .3, .3, 0, c_orange, c_orange, c_orange, c_orange, 1);

var btn_width = 120;
var btn_height = 40;

DrawButton(room_width/2, room_height/2 + 100, btn_width, btn_height, "Retry", Retry);
DrawButton(room_width/2, room_height/2 + 200, btn_width, btn_height, "Quit", QuitToMenu, c_gray, c_red);