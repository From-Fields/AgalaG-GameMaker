/// @description Insert description here
// You can write your code in this editor

if(!_isDead) {
	if(_inputHandler.HasMovement())
		Move(_inputHandler.GetMovement(), _currentSpeed)
	if(_inputHandler.GetShoot())
		Shoot()
}