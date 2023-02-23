// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ApplyMovement(_direction, _speed, _acceleration = 10) {
	var _currentDirection = _direction.Normalized();
	
	var _horizontalMovement = _currentDirection._x * _speed;
	var _verticalMovement = _currentDirection._y * _speed;
	
	var _dt = delta_time / 1000000;

	x = lerp(x, x + _horizontalMovement, _dt * _acceleration);
	y = lerp(y, y + _verticalMovement, _dt * _acceleration);
}

function ApplyPhisicsMovement(_direction, _speed, _acceleration = 10) {
	var _currentDirection = _direction.Normalized();
	
	var _horizontalMovement = _currentDirection._x * _speed;
	var _verticalMovement = _currentDirection._y * _speed;
	
	var _dt = delta_time / 1000000;

	phy_linear_velocity_x = lerp(phy_linear_velocity_x, _horizontalMovement, _dt * _acceleration);
	phy_linear_velocity_y = lerp(phy_linear_velocity_y, _verticalMovement, _dt * _acceleration);
}