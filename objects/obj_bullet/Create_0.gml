_damage = 1;
_sprite = noone;
_direction = new Vector2(0, 0);
_speed = 2;
_isPlayer = true;

alarm[0] = room_speed * 2.5;

Initialize = function(dir, spd, isPlayer, spr = spr_bullet, dmg = 1) {
	_direction = dir;
	_speed = spd;
	_sprite = spr;
	_damage = dmg;
	_isPlayer = isPlayer;
	
	sprite_index = _sprite;
}

DestroySelf = function() {
	instance_destroy();
}

Move = function(_direction, _speed) {
	ApplyMovement(_direction, _speed)
}