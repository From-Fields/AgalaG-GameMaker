/// @description Insert description here
// You can write your code in this editor

event_inherited()

// Attributes
_isDead = false;
_defaultWeapon = noone;
_weapon = _defaultWeapon;

_defaultSpeed = 500;
_currentSpeed = _defaultSpeed;

_defaultAcceleration = 10;
_currentAcceleration = _defaultAcceleration;

_maxHealth = 3;
_health = _maxHealth;

_powerUps = ds_list_create();
_inputHandler = new InputHandler();

// Methods
SwitchWeapon = function(_newWeapon) {
	if(_newWeapon != noone)	
		_weapon = _newWeapon;
}

AddPowerUp = function(_newPowerUp) {
	if(_newPowerUp != noone && ds_list_find_index(_powerUps, _newPowerUp) == -1) {
		ds_list_add(_powerUps, _newPowerUp);
	}
}
RemovePowerUp = function(_powerUp) {
	var _index = ds_list_find_index(_powerUps, _powerUp);
	
	if(_powerUp != noone && _index != 1) {
		ds_list_delete(_powerUps, _index);
	}
}

Heal = function(_amount) {
	_health = clamp(_health + _amount, 0, _maxHealth);	
}

// Interface Implementation
TakeDamage = function(_amount) {
	_health = clamp(_health - _amount, 0, _maxHealth);
	
	if(_health == 0) {
		Die();
	}
}

Move = function(_direction, _speed, _acceleration) {
	var _currentDirection = _direction.Normalized();
	
	show_debug_message(string(_currentDirection._x) + " " + string(_currentDirection._y));
	
	var _horizontalMovement = _currentDirection._x * _speed;
	var _verticalMovement = _currentDirection._y * _speed;
	
	var _dt = delta_time / 1000000;

	phy_linear_velocity_x = lerp(phy_linear_velocity_x, _horizontalMovement, _dt * _acceleration);
	phy_linear_velocity_y = lerp(phy_linear_velocity_y, _verticalMovement, _dt * _acceleration);

	//x = lerp(x, x + _horizontalMovement, _dt * _acceleration);
	//y = lerp(y, y + _verticalMovement, _dt * _acceleration);
	
	//show_debug_message(x)
	
	//x += _horizontalMovement;
	//y += _verticalMovement;
}

Shoot = function(){
	show_debug_message("pew!");
}
Die = function(){
	show_debug_message("NANI");
	_isDead = true;
}
