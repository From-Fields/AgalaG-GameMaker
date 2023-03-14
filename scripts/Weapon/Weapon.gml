function Weapon(bullet) constructor {
	_bullet = bullet;
	_spawnPoint = [ new Vector2(0, 0) ];
	_maxAmmunition = 999;
	_currentAmmunition = 999;
	_speed = 2;
	_layer = "Instances"
	
	Initialize = function() {
	}
	
	isEmpty = function() {
	}
	
	Shoot = function(position) {
		//show_debug_message("PEW!");
	}
}

///@function DefaultWeapon();
///@description Creates a default weapon
function DefaultWeapon(bullet = obj_bullet) : Weapon(bullet) constructor {
	_spawnPoint = new Vector2(0, -10);
	_speed = 50;
	
	Shoot = function(position) {
		var bullet_inst = instance_create_layer(_spawnPoint._x + position._x, _spawnPoint._y + position._y, _layer, _bullet);
		bullet_inst.Initialize(new Vector2(0, -1), _speed, true);
	}
}