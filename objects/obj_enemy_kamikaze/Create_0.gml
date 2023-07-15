/// @description Insert description here
// You can write your code in this editor
event_inherited()

_health = 1;
_suicideDamage = 1;
_score = 10;

//Entity Implementation
Shoot = function() { }
TakeDamage = function(_amount) {
	_health = clamp(_health - _amount, 0, _maxHealth);
	
	if(_health == 0)
		Die();
}
Move = function(_direction, _speed, _acceleration) {
	ApplyPhisicsMovement(_direction, _speed, _acceleration);	
}

//Poolable Implementation
CreateFunction = function() { return instance_create_layer(0, 0, "Instances", obj_enemy_kamikaze); }
ReserveToPool = function() { Pool().Release(id); }
Pool = function() { return new EnemyKamikazePool().Instance(); }