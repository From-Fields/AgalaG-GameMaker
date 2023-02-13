/// @description Insert description here
// You can write your code in this editor
event_inherited()

_health = 1;
_suicideDamage = 1;

Die = function() {
	_isDead = true;
	Reserve();
}
Shoot = function() {
	show_debug_message("Take that!");	
}
TakeDamage = function(_amount) {
	_health = clamp(_health - _amount, 0, _maxHealth);
	
	if(_health == 0)
		Die();
}

Move = function(_direction, _speed, _acceleration) {
	var _currentDirection = _direction.Normalized();
	
	var _horizontalMovement = _currentDirection._x * _speed;
	var _verticalMovement = _currentDirection._y * _speed;
	
	var _dt = delta_time / 1000000;

	phy_linear_velocity_x = lerp(phy_linear_velocity_x, _horizontalMovement, _dt * _acceleration);
	phy_linear_velocity_y = lerp(phy_linear_velocity_y, _verticalMovement, _dt * _acceleration);	
}

_queue = ds_queue_create();
ds_queue_enqueue(_queue, new MoveTowards(1, 1, 1, 180, 5, new Vector2(280, 64)));
ds_queue_enqueue(_queue, new Shoot(2));
ds_queue_enqueue(_queue, new MoveTowards(4, 1, 0.05, 40, 5, obj_player));
Initialize(_queue, new WaitSeconds(2), new WaitSeconds(2), _position());