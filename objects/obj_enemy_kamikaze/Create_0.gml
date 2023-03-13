/// @description Insert description here
// You can write your code in this editor
event_inherited()

_health = 1;
_suicideDamage = 1;

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
CreateFunction = function() { return instance_create_layer(0, 0, "Entities", obj_enemy_kamikaze); }
Reserve = function() { Pool().Release(id); }
Pool = function() { return new EnemyKamikazePool().Instance(); }

_queue = ds_queue_create();
ds_queue_enqueue(_queue, new MoveTowards(1, 1, 1, 180, 5, new Vector2(280, 64)));
ds_queue_enqueue(_queue, new ShootInSeconds(2));
ds_queue_enqueue(_queue, new MoveTowards(4, 1, 0.05, 40, 5, obj_player));
Initialize(_queue, new WaitSeconds(2), new WaitSeconds(2), _position());