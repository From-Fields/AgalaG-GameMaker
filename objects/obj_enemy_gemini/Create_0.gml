/// @description Insert description here
// You can write your code in this editor
event_inherited()

_geminiPositionOffset = 100;
_orbitingVelocity = 1;
_geminiMissileDamage = 1;
_weaponCooldown = 1;
_missileSpeed = 50;

_defaultHealth = 2;

_children = ds_list_create();
_childPool = new EnemyGeminiChildPool().Instance();

_score = 10;

SubInitialize = function() {
	visible = false;
	_maxHealth = _defaultHealth;
	_currentHealth = _defaultHealth;
}

//Entity Implementation
TakeDamage = function(_amount) {
	_currentHealth = clamp(_currentHealth - _amount, 0, _maxHealth);
	
	if(_currentHealth == 0)
		Die();
}
Move = function(_direction, _speed, _acceleration) {
	ApplyPhisicsMovement(_direction, _speed, _acceleration);	
	
	var length = ds_list_size(_children)
	
	for(i = 0; i < length; i++) {
		var child = ds_list_find_value(_children, i);
        child.Move(_direction, _speed, _acceleration);
    }
}
Stop = function() {
	ApplyPhisicsMovement(new Vector2(0, 0), 0, 0.9);
	var length = ds_list_size(_children);
	
	for(i = 0; i < length; i++) {
		var child = ds_list_find_value(_children, i);
        child.Stop();
    }
}
Shoot = function() {	
	var length = ds_list_size(_children);
	
	for(i = 0; i < length; i++) {
		var child = ds_list_find_value(_children, i);
        child.Shoot();
    }
}

SubInitialize = function()
{
    _isDead = false;
    _maxHealth = _defaultHealth;
    _currentHealth = _defaultHealth;

    _defaultSpeed = 500;
    _defaultAcceleration = 10;

    _currentSpeed = _defaultSpeed;
    _currentAcceleration = _defaultAcceleration;
    _collisionDamage = _defaultCollisionDamage;

    for (i = 0; i < _defaultHealth; i++) {
        ds_list_add(_children, _childPool.Get());
        var child = ds_list_find_value(_children, i);
        yOffset = (i < 1) ? -1 * _geminiPositionOffset : _geminiPositionOffset;
        var position = new Vector2(_position()._x, _position()._y + yOffset);

        child.Initialize(ds_queue_create(), undefined, new WaitSeconds(200), position);
        child.SetParent(self, _geminiPositionOffset, _orbitingVelocity);
        child.SetWeapon(_weaponCooldown, _geminiMissileDamage, _missileSpeed);
    }
}

SubReserve = function() {
	var length = ds_list_size(_children)
	
	for(i = 0; i < length; i++) {
		var child = ds_list_find_value(_children, i);
        if(!child._isDead)
            child.Reserve();
    }
    ds_list_clear(_children);
}

//Poolable Implementation
CreateFunction = function() { return instance_create_layer(0, 0, "Instances", obj_enemy_gemini); }
ReserveToPool = function() { Pool().Release(id); }
Pool = function() { return new EnemyGeminiPool().Instance(); }