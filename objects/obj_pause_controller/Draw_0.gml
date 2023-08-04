/// @description Insert description here
// You can write your code in this editor

if(_paused) {
	if(!surface_exists(paused_surf)) {
		if (paused_surf) == -1 {
		    instance_deactivate_all(true);
		}
		
		paused_surf = surface_create(room_width, room_height);
		surface_set_target(paused_surf);
		draw_surface_stretched(application_surface, 0, 0, room_width, room_height);
		surface_reset_target();
	}
	else {
		draw_surface_stretched(paused_surf, 0, 0, room_width, room_height);
		draw_set_alpha(0.4);
		draw_rectangle_colour(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
	
	
		draw_set_alpha(1);
		draw_set_font(default_font);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed_color(room_width/2, room_height/6, "Paused", 1, 1, 0, c_orange, c_orange, c_orange, c_orange, 1);


		var btn_width = 120;
		var btn_height = 40;

		DrawButton(room_width/2, room_height/2, btn_width, btn_height, "Resume", ResumeGame);
		DrawButton(room_width/2, room_height/2 + 100, btn_width, btn_height, "Retry", Retry);
		DrawButton(room_width/2, room_height/2 + 200, btn_width, btn_height, "Quit", QuitToMenu, c_gray, c_red);
	}
}
