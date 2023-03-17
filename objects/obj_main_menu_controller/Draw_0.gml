draw_set_font(default_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed_color(room_width/2, room_height/6, "AgalaG", 1, 1, 0, c_orange, c_orange, c_orange, c_orange, 1);


var btn_width = 120;
var btn_height = 40;


var startGame = function() {
	room_goto(Room1);
}

var settings = function() {
	show_debug_message("Settings clicked!");
}

var exitGame = function() {
	game_end();
}

DrawButton(room_width/2, room_height/2, btn_width, btn_height, "Start Game", startGame);
DrawButton(room_width/2, room_height/2 + 100, btn_width, btn_height, "Settings", settings);
DrawButton(room_width/2, room_height/2 + 200, btn_width, btn_height, "Exit", exitGame, c_gray, c_red);