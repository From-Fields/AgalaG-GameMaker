_damage = 1;
_sprite = noone;
_direction = new Vector2(0, 0);
_speed = 2;
_isPlayer = true;

alarm[0] = room_speed * 2.5;

Initialize = function(damage, direction_, speed_, isPlayer, sprite = spr_bullet) {
	_direction = direction_;
	_speed = speed_;
	_sprite = sprite;
	_damage = damage;
	_isPlayer = isPlayer;
	
	sprite_index = _sprite;
}

DestroySelf = function() {
	instance_destroy();
}

Move = function(_direction, _speed) {
	ApplyMovement(_direction, _speed)
}