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

_shotSound = sfx_shot_player;
_moveSound = sfx_move_player;
_deathSound = sfx_death_player;
_damageSound = sfx_dmg_player;
_powerUpSound = sfx_powerup;

_moveSoundInstance = audio_play_sound_on(_audioEmitter, _moveSound, true, 0);

// Methods
SwitchWeapon = function(_newWeapon) {
	show_debug_message("change weapon");
	if(_newWeapon != noone)	
		_currentWeapon = _newWeapon;
		
	_currentWeapon.SetWeaponAudio(_shotSound, _audioEmitter);
}

SwitchDefaultWeapon = function() {
	SwitchWeapon(_defaultWeapon);
}

AddPowerUp = function(_newPowerUp) {
	_newPowerUp.OnPickup(id);

    if(_newPowerUp.isInstant) {
		audio_play_sound_on(_audioEmitter, _powerUpSound, false, 5);
        return;
	}
	
	if(_newPowerUp != noone && ds_list_find_index(_powerUps, _newPowerUp) == -1) {
		ds_list_add(_powerUps, _newPowerUp);
		audio_play_sound_on(_audioEmitter, _powerUpSound, false, 5);
	}
}
RemovePowerUp = function(_powerUp) {
	var _index = ds_list_find_index(_powerUps, _powerUp);
	
	if(_powerUp != noone && _index >= 0) {
		ds_list_delete(_powerUps, _index);
	}
}

Heal = function(_amount) {
	show_debug_message("Heal: " + string(_amount) + " + " + string(_health));
	_health = clamp(_health + _amount, 0, _maxHealth);
	show_debug_message(string(_health));
}

// Interface Implementation
TakeDamage = function(_amount) {
	_damage = _amount;

	for (i = 0; i < ds_list_size(_powerUps); i++) {
	    _damage = ds_list_find_value(_powerUps, i).OnTakeDamage(_damage, _health); 
		if(_damage == 0)
			return;
	}
	
	audio_play_sound_on(_audioEmitter, _damageSound, false, 0);
	
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
	
	if (_currentWeapon.isEmpty()) {
		SwitchDefaultWeapon();
	}
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
	
	audio_play_sound_on(_audioEmitter, _deathSound, false, 10);
	
	if(_moveSoundInstance != noone)
		audio_stop_sound(_moveSoundInstance);
	
	onDeath.Invoke();
}

SwitchDefaultWeapon();
