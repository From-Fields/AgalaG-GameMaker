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
onDeath = new EventListener();

// Methods
SwitchWeapon = function(_newWeapon) {
	if(_newWeapon != noone)	
		_currentWeapon = _newWeapon;
}

SwitchDefaultWeapon = function() {
	SwitchWeapon(_defaultWeapon);
}

AddPowerUp = function(_newPowerUp) {
	_newPowerUp.OnPickup(id);

    if(_newPowerUp.isInstant)
        return;
	
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
	_damage = _amount;

	for (i = 0; i < ds_list_size(_powerUps); i++) {
	    _damage = ds_list_find_value(_powerUps, i).OnTakeDamage(_damage, _currentHealth); 
	}
	
	_health = clamp(_health - _damage, 0, _maxHealth);
	
	if(_health == 0) {
		Die();
	}
}

Move = function(_direction, _speed, _acceleration) {
	ApplyPhisicsMovement(_direction, _speed, _acceleration);
}
Stop = function() {
	ApplyPhisicsMovement(new Vector2(0, 0), 0, 0.9);
}

Shoot = function() {
	_currentWeapon.Shoot(_position());
}

Die = function(){
	//show_debug_message("NANI");
	die = true;    

    for (i = 0; i < ds_list_size(_powerUps); i++)
        die = ds_list_find_value(_powerUps, i).OnDeath();

    if(!die)
        return;
		
	_isDead = true;
	visible = false;
	onDeath.Invoke();
}
