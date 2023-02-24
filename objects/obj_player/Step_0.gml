/// @description Insert description here
// You can write your code in this editor

if(!_isDead) {
	_movement = (_inputHandler.HasMovement()) ? _inputHandler.GetMovement() : new Vector2(0, 0);
	Move(_movement, _currentSpeed, _currentAcceleration);
	if(_inputHandler.GetShoot()) {
		Shoot();
	}
}