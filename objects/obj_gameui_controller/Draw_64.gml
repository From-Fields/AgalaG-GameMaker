var view_w = view_wport[0];
var view_h = view_hport[0];

if (instance_exists(obj_player)) {
	var ship_icon_size = .4;
	for (var i = 0; i < 3; i++) {
		
		draw_sprite_ext(spr_player, 0, 60 + 50 * i, view_h - 50, ship_icon_size, ship_icon_size, 0, c_white, (obj_player._health - 1 >= i));
	}
	
	var shield_size = .8;
	for (var i = 0; i < 6; i++) {
		draw_sprite_ext(spr_powerup_shield, 0, 60 + 50 * i, view_h - 15, shield_size, shield_size, 0, c_white, (obj_player.shield - 1) >= i);
	}
	
	draw_sprite_ext(obj_player._currentWeapon._sprite, 0, view_w - 200, view_h - 50, .5, .5, 0, c_white, 1);
	draw_text_transformed(view_w - 50, view_h - 50, obj_player._currentWeapon.AmmoToString(), .2, .2, 0);
}

if (instance_exists(obj_levelController)) {
	draw_text_transformed(view_w - 180, view_h - 15, "Score: ", .2, .2, 0);
	draw_text_transformed_color(view_w - 50, view_h - 15, string(obj_levelController._score), .28, .28, 0, c_orange, c_orange, c_orange, c_orange, 1);
}

