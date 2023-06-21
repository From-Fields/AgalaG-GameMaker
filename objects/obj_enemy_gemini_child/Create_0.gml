/// @description Insert description here
// You can write your code in this editor
event_inherited()

//Attributes
_positionOffset = new Vector2(0, 0);
_velocityMultiplier = 20;
_orbitingVelocity = 1;
_orbitMultiplier = 100;
_desiredVelocity = undefined;

_parent = noone;
_bulletSprite = spr_bullet_gemini;
_weapon = new DefaultWeapon(false, _bulletSprite);

//auxVectors
_toChild = undefined; 
_fromChild = undefined;
_tangent = undefined;

_currentHealth = 1;

_defaultCollisionDamage = 1;
_score = 10;

SetParent = function(parent, positionOffset, orbitingVelocity) {
    _parent = parent;
    _positionOffset = positionOffset;
    _orbitingVelocity = orbitingVelocity;
}
SetWeapon = function(weaponCooldown, missileDamage, missileSpeed) {
    _weapon.SetAttributes(missileSpeed, missileDamage, weaponCooldown, new Vector2(0, 1), -1, new Vector2(50, 50));
}

SubInitialize = function() {
	_currentHealth = _maxHealth;

    _defaultSpeed = 10;
    _defaultAcceleration = 10;
            
    _currentSpeed = _defaultSpeed;
    _currentAcceleration = _defaultAcceleration;
    _collisionDamage = _defaultCollisionDamage;
	
	onDeath.AddListener(DamageParent)
}

DamageParent = function() {
	_parent.TakeDamage(1);
}

//Entity Implementation
Shoot = function() {
	show_debug_message("Shoot")
	_weapon.Shoot(_position());
}
TakeDamage = function(_amount) {
	_currentHealth = clamp(_currentHealth - _amount, 0, _maxHealth);
	
	if(_currentHealth == 0)
		Die();
}
Move = function(_direction, _speed, _acceleration) {
	_desiredVelocity = _direction.Multiply(_speed);
}
Stop = function() {
	_desiredVelocity = new Vector2(0, 0);
}

//Poolable Implementation
CreateFunction = function() { return instance_create_layer(0, 0, "Instances", obj_enemy_gemini_child); }
ReserveToPool = function() { Pool().Release(id); }
Pool = function() { return new EnemyGeminiChildPool().Instance(); }

