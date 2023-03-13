/// @description Insert description here
// You can write your code in this editor

event_inherited()
phy_fixed_rotation = true;

// Attributes
_isDead = false;
_defaultWeapon = new DefaultWeapon();
_currentWeapon = _defaultWeapon;

_defaultSpeed = 500;
_currentSpeed = _defaultSpeed;

_defaultAcceleration = 10;
_currentAcceleration = _defaultAcceleration;

_maxHealth = 3;
_health = _maxHealth;

_powerUps = ds_list_create();
_inputHandler = new InputHandler().Instance();

// Methods
SwitchWeapon = function(_newWeapon) {
	if(_newWeapon != noone)	
		_currentWeapon = _newWeapon;
}

SwitchDefaultWeapon = function() {
	SwitchWeapon(_defaultWeapon);
}

AddPowerUp = function(_newPowerUp) {
	if(_newPowerUp != noone && ds_list_find_index(_powerUps, _newPowerUp) == -1) {
		ds_list_add(_powerUps, _newPowerUp);
	}
}
RemovePowerUp = function(_powerUp) {
	var _index = ds_list_find_index(_powerUps, _powerUp);
	
	if(_powerUp != noone && _index >= 0) {
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
	ApplyPhisicsMovement(_direction, _speed, _acceleration);
}

Shoot = function() {
	_currentWeapon.Shoot(new Vector2(x, y));
}

Die = function(){
	show_debug_message("NANI");
	_isDead = true;
	instance_deactivate_object(id);
}
