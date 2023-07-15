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

SubInitialize = function() {
	_maxHealth = _defaultHealth;
	_currentHealth = _defaultHealth;

    _defaultSpeed = 500;
    _defaultAcceleration = 10;
            
    _currentSpeed = _defaultSpeed;
    _currentAcceleration = _defaultAcceleration;

    _collisionDamage = _defaultCollisionDamage;

	SetWeapon(_weaponCooldown, _weaponDamage, _missileSpeed);
}


SetWeapon = function(weaponCooldown, missileDamage, missileSpeed) {
    _weapon.SetAttributes(missileSpeed, missileDamage, weaponCooldown, new Vector2(0, 1), -1, new Vector2(100, 100));
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
CreateFunction = function() { return instance_create_layer(0, 0, "Instances", obj_enemy_bumblebee); }
ReserveToPool = function() { Pool().Release(id); }
Pool = function() { return new EnemyBumblebeePool().Instance(); }