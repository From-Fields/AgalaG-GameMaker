/// @description Insert description here
// You can write your code in this editor

DoRotation = function() {
    if(!_rotate)
        return;

	var _dt = delta_time / 1000000;
	
    _currentAngle = math_repeat(_currentAngle + _rotationSpeed * _dt, 360);
	phy_rotation = _currentAngle;
}

CheckPosition = function() {
	if(_isWithinBounds) {
		if(!_willRemove && (!_canBounce || _currentBounces > _maxBounces))
			CheckWallCollision();	
        return;
	}
	
    isWithinX = phy_position_x > sprite_width && phy_position_x < room_width - sprite_width;
	isWithinY = phy_position_y > sprite_height && phy_position_y < room_height - sprite_height;
	
	if(isWithinX && isWithinY) {
		_isWithinBounds = true;
		SetCollisionGroup(-2);
	}
}

CheckWallCollision = function() {
	if(instance_place(x, y, obj_wall)) {
		_willRemove = true;
		
		_timer_a = time_source_create(time_source_game, 1.5, time_source_units_seconds, ReserveToPool);
		time_source_start(_timer_a);
	}
	
}

DoRotation();
CheckPosition();

_velocity = new Vector2(phy_linear_velocity_x, phy_linear_velocity_y);

