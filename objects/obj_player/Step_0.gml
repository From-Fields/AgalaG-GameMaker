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