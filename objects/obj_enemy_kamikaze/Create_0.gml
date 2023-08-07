/// @description Insert description here
// You can write your code in this editor
event_inherited()

_defaultHealth = 1;
_currentHealth = 1;
_defaultCollisionDamage = 1;
_score = 10;

_moveSound = sfx_move_kamikaze;

SubInitialize = function() {
	_maxHealth = _defaultHealth;
	_currentHealth = _defaultHealth;
}

//Entity Implementation
Shoot = function() {}
TakeDamage = function(_amount) {
	_currentHealth = clamp(_currentHealth - _amount, 0, _maxHealth);
	
	if(_currentHealth == 0)
	{
		Die();
		obj_levelController.UpdateScore(_score);
	}
}
Move = function(_direction, _speed, _acceleration) {
	ApplyPhisicsMovement(_direction, _speed, _acceleration);	
}
Stop = function() {
	ApplyPhisicsMovement(new Vector2(0, 0), 0, 0.9);
}

//Poolable Implementation
CreateFunction = function() { return instance_create_layer(0, 0, "Instances", obj_enemy_kamikaze); }
ReserveToPool = function() { Pool().Release(id); }
Pool = function() { return new EnemyKamikazePool().Instance(); }