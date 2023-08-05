/// @description Insert description here
// You can write your code in this editor
event_inherited()

_weaponDamage = 1;
_weaponCooldown = 0.8;
_missileSpeed = 50;

_bulletSprite = spr_bullet_bumblebee;
_weapon = new DefaultWeapon(false, _bulletSprite);

_defaultHealth = 1;
_currentHealth = 1;
_defaultCollisionDamage = 1;

_score = 10;

_shotSound = sfx_shot_bumble;
_moveSound = sfx_move_bumble;

SubInitialize = function() {
	_maxHealth = _defaultHealth;
	_currentHealth = _defaultHealth;

    _defaultSpeed = 700;
    _defaultAcceleration = 10;
            
    _currentSpeed = _defaultSpeed;
    _currentAcceleration = _defaultAcceleration;

    _collisionDamage = _defaultCollisionDamage;

	SetWeapon(_weaponCooldown, _weaponDamage, _missileSpeed);
}


SetWeapon = function(weaponCooldown, missileDamage, missileSpeed) {
    _weapon.SetAttributes(missileSpeed, missileDamage, weaponCooldown, new Vector2(0, 1), -1, new Vector2(0, 50));
	_weapon.SetWeaponAudio(_shotSound, _audioEmitter);
}

//Entity Implementation
Shoot = function() {
	_weapon.Shoot(_position());
}
TakeDamage = function(_amount) {
	_currentHealth = clamp(_currentHealth - _amount, 0, _maxHealth);
	
	if(_currentHealth == 0)
		Die();
}
Move = function(_direction, _speed, _acceleration) {
	ApplyPhisicsMovement(_direction, _speed, _acceleration);	
}
Stop = function() {
	ApplyPhisicsMovement(new Vector2(0, 0), 0, 0.9);
}

//Poolable Implementation
ReserveToPool = function()  { 
	if(_isReserved)
		return;
	Pool().Release(id);
	_isReserved = true;
}
Pool = function() { return new EnemyBumblebeePool().Instance(); }