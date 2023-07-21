switch (state) {
	case states.mainOptions:
	#region mainOptions
		draw_set_font(default_font);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed_color(room_width/2, room_height/6, "AgalaG", 1, 1, 0, c_orange, c_orange, c_orange, c_orange, 1);


		var btn_width = 120;
		var btn_height = 40;

		DrawButton(room_width/2, room_height/2, btn_width, btn_height, "Start Game", startGame);
		DrawButton(room_width/2, room_height/2 + 100, btn_width, btn_height, "Settings", settings);
		DrawButton(room_width/2, room_height/2 + 200, btn_width, btn_height, "Exit", exitGame, c_gray, c_red);
	
	#endregion		
		break;

	case states.settings:
	#region Settings
		draw_set_font(default_font);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed_color(room_width/2, room_height/6, "Settings", 1, 1, 0, c_white, c_white, c_gray, c_gray, 1);
		
		var x_pos = room_width/2 - 180;
		
		draw_set_halign(fa_left);
		draw_text_transformed(x_pos, room_height/3, "Fullscreen: ", .25, .25, 0);
		DrawToggleButton(room_width/2 + 280, room_height/3, 20, 20, fullscreen_active, fullscreenPressed);
	
		draw_text_transformed(x_pos, room_height/2, "Master volume: ", .25, .25, 0);
		DrawSlider(room_width/2 + 150, room_height/2, 200, 10, master_volume_pos, onChangeMasterVolume);
		
		draw_text_transformed(x_pos, room_height/2 + 100, "Music volume: ", .25, .25, 0);
		DrawSlider(room_width/2 + 150, room_height/2 + 100, 200, 10, music_volume_pos, onChangeMusicVolume);
		
		draw_text_transformed(x_pos, room_height/2 + 200, "SFX volume: ", .25, .25, 0);
		DrawSlider(room_width/2 + 150, room_height/2 + 200, 200, 10, sfx_volume_pos, onChangeSFXVolume);
		
		draw_set_halign(fa_center);
		DrawButton(room_width/2, room_height/2 + 300, 80, 30, "Voltar", function() { state = states.mainOptions; });
		
	#endregion
	
		break;
}