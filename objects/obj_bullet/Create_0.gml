_damage = 1;
_sprite = noone;
_direction = new Vector2(0, 0);
_speed = 2;
_isPlayer = true;
_explosion = false;

Initialize = function(damage, direction_, speed_, isPlayer, sprite = spr_bullet, life = 2.5, explosion = false, size = 1) {
	_direction = direction_;
	_speed = speed_;
	_sprite = sprite;
	_damage = damage;
	_isPlayer = isPlayer;
	_explosion = explosion;
	
	if(direction_._y > 0)
		image_angle = 180;
	
	sprite_index = _sprite;
	alarm[0] = room_speed * life;
	
	image_xscale = size;
	image_yscale = size;
}

DestroySelf = function() {
	if (_explosion) {
		instance_create_layer(x, y, layer, obj_explosion);
	}
	
	instance_destroy();
}

Move = function(_direction, _speed) {
	ApplyMovement(_direction, _speed)
}