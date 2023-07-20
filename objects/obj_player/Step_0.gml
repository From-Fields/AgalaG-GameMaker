if(_isDead) exit;

for (i = 0; i < ds_list_size(_powerUps); i++)
    ds_list_find_value(_powerUps, i).OnTick();
	
_movement = (_inputHandler.HasMovement()) ? _inputHandler.GetMovement() : new Vector2(0, 0);
Move(_movement, _currentSpeed, _currentAcceleration);

if(_inputHandler.GetShoot()) {
	Shoot();
}

// DEBUG
if (keyboard_check_pressed(vk_f2)) {
	SwitchWeapon(new MissileWeapon());
}
else if (keyboard_check_pressed(vk_f3)) {
	SwitchWeapon(new TripleMachineGun());
}


if(_isInvulnerable) {
	_frameAccumulator++;
	
	if(_frameAccumulator > 5) {
		_frameAccumulator = 0;
		image_alpha = (image_alpha == 1) ? 0.3 : 1;
	}
}

if(!_isInvulnerable && image_alpha != 1)
	image_alpha = 1;
