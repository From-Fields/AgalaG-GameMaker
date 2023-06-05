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
	_damage = 1;
	_cooldown = 0.1;
	_direction = new Vector2(0, -1);
	
	_canShoot = true;
	
	Shoot = function(position) {
		if(!_canShoot)
			return;
		
		StartCooldown();
		
		var bullet_inst = instance_create_layer(_spawnPoint._x + position._x, _spawnPoint._y + position._y, _layer, _bullet);
		bullet_inst.Initialize(_damage, _direction, _speed, true);
	}
	
	StartCooldown = function()  {
        if(_cooldown <= 0)
            return;

        _canShoot = false;
		time_source_start(time_source_create(time_source_game, _cooldown, time_source_units_seconds, OnCooldownEnd));
    }
    OnCooldownEnd = function() {
		_canShoot = true;
	}
	
	SetAttributes = function(direction_ = undefined, maxAmmunition = -1, speed_ = -1, cooldown = -1, damage = -1) {
        _direction = (direction_ != undefined) ? direction_ : new Vector2(0, -1);
        _maxAmmunition = (maxAmmunition != -1) ? maxAmmunition : _maxAmmunition;
        _speed = (speed != -1) ? speed : _speed;
        _cooldown = (cooldown != -1) ? cooldown : _cooldown;
        _damage = (damage != -1)? damage : _damage;
     }
}