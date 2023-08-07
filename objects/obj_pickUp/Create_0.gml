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
_audioEmitter = audio_emitter_create();
_bounceSound = sfx_bounce;

Initialize = function(
    powerUp, position, direction_, speed_ = 2000, 
    rotate = true, rotationSpeed = 150, 
    doScale = true, maximumScale = 1.3, scaleSpeed = 5
) {
	_bounceCooldown = true;
	
    _rotate = rotate;
    _doScale = doScale;
    _rotationSpeed = rotationSpeed;
    _maximumScale = maximumScale;
    _scaleSpeed = scaleSpeed;
	_currentAngle = 0;

    _powerUp = powerUp;
    sprite_index = powerUp.sprite;
    
	phy_active = true;
	
	SetPosition(position._x, position._y);
	
	phy_fixed_rotation = true;
	visible = true;
	instance_activate_object(id);
            
	_velocity = undefined;
	_direction = direction_;
	_speed = speed_;
    ApplyPhisicsMovement(direction_, speed_);
	
	_timer = undefined;
	_pause = instance_find(obj_pause_controller, 0);
	_pause.onPause.AddListener(OnPause);
}

SetPosition = function(_x, _y) {
	if(_x <= 0)	
		_x = sprite_width;
	if(_x >= room_width)
		_x = room_width - sprite_width
		
		
	if(_y <= 0)	
		_y = sprite_height;
	if(_y >= room_height)
		_y = room_height - sprite_height
		
		
    x = _x;
    y = _y;
    phy_position_x = _x;
    phy_position_y = _y;
}

Pool  = function() { return new PickUpPool().Instance(); }
ResetCooldown = function() { _bounceCooldown = true; }

OnPause = function(paused) {
	if(_timer == undefined)
		return;
		
	if(paused)
		time_source_pause(_timer);
	else
		time_source_resume(_timer);
}