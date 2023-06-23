/// @description Insert description here
// You can write your code in this editor

_rotate = false;
_doScale = false;
_scaleUp = true;
_rotationSpeed = undefined;
_maximumScale = undefined;
_scaleSpeed = undefined;

// References
_powerUp = undefined;

x = 0;
y = 0;

visible = false;
instance_deactivate_object(id);

Initialize = function(
    powerUp, position, direction_, speed_ = 750, 
    rotate = true, rotationSpeed = 100, 
    doScale = true, maximumScale = 1.3, scaleSpeed = 5
) {
    _rotate = rotate;
    _doScale = doScale;
    _rotationSpeed = rotationSpeed;
    _maximumScale = maximumScale;
    _scaleSpeed = scaleSpeed;
	_currentAngle = 0;

    _powerUp = powerUp;
    sprite_index = powerUp.sprite;
    
	phy_active = true;
	
    x = position._x;
    y = position._y;
    phy_position_x = position._x;
    phy_position_y = position._y;
    
	phy_fixed_rotation = true;
	visible = true;
	instance_activate_object(id);
            
	_velocity = undefined;
	_direction = direction_;
	_speed = speed_;
    ApplyPhisicsMovement(direction_, speed_);
}

Pool  = function() { return new PickUpPool().Instance(); }