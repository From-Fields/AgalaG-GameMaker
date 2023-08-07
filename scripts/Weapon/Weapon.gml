function Weapon(bullet) constructor {
	_bullet = bullet;
	_spawnPoint = [ new Vector2(0, 0) ];
	_maxAmmunition = 999;
	_currentAmmunition = 999;
	_speed = 2;
	_layer = "Instances"
	
	_audioId = noone;
	_audioEmitter = noone;
	
	AmmoToString = function() { 
		return string(_currentAmmunition); 
	}
	
	Initialize = function() {
	}
	
	isEmpty = function() {
	}
	
	Shoot = function(position) {
		//show_debug_message("PEW!");
	}
	
	SetWeaponAudio = function(audioId, audioEmitter) {
		_audioId = audioId;
		_audioEmitter = audioEmitter;
	}
	OnPause = function(paused) {
		if(_timer == undefined)
			return;
		
		if(paused)
			time_source_pause(_timer);
		else
			time_source_resume(_timer);
	}
	
	_timer = undefined;
	_pause = instance_find(obj_pause_controller, 0);
	_pause.onPause.AddListener(OnPause);
}

///@function DefaultWeapon();
///@description Creates a default weapon
function DefaultWeapon(isPlayer = true, sprite_ = spr_bullet, bullet = obj_bullet) : Weapon(bullet) constructor {
	_spawnPoint = new Vector2(0, -10);
	_speed = 50;
	_damage = 1;
	_cooldown = 0.3;
	_direction = new Vector2(0, -1);
	
	_sprite = sprite_;
	_isPlayer = isPlayer;
	
	_canShoot = true;
	
	_timer = undefined;
	
	AmmoToString = function() { 
		return "-"; 
	}
	
	Shoot = function(position) {
		if(!_canShoot)
			return;
		
		StartCooldown();
		
		var bullet_inst = instance_create_layer(_spawnPoint._x + position._x, _spawnPoint._y + position._y, _layer, _bullet);
		bullet_inst.Initialize(_damage, _direction, _speed, _isPlayer, _sprite);
		
		if(_audioEmitter != noone && _audioId != noone)
			audio_play_sound_on(_audioEmitter, _audioId, false, 3);
	}
	
	StartCooldown = function()  {
        if(_cooldown <= 0)
            return;

        _canShoot = false;
		_timer = time_source_create(time_source_game, _cooldown, time_source_units_seconds, OnCooldownEnd);
		time_source_start(_timer);
    }
    OnCooldownEnd = function() {
		_canShoot = true;
	}
	
	SetAttributes = function(speed_ = -1, damage = -1, cooldown = -1, direction_ = undefined, maxAmmunition = -1, spawnPoint = undefined) {
        _direction = (direction_ != undefined) ? direction_ : new Vector2(0, -1);
        _maxAmmunition = (maxAmmunition != -1) ? maxAmmunition : _maxAmmunition;
        _speed = (speed_ != -1) ? speed_ : _speed;
        _cooldown = (cooldown != -1) ? cooldown : _cooldown;
        _damage = (damage != -1)? damage : _damage;
		_spawnPoint = (spawnPoint != undefined) ? spawnPoint : _spawnPoint;
     }
}

function MissileWeapon (isPlayer = true, sprite_ = spr_bullet, bullet = obj_bullet) : Weapon(bullet) constructor {
	_spawnPoint = new Vector2(0, -20);
	_speed = 20;
	_damage = 2;
	_cooldown = 0.8;
	_direction = new Vector2(0, -1);
	_maxAmmunition = 15;
	_currentAmmunition = _maxAmmunition;
	
	_sprite = spr_missile;
	_isPlayer = isPlayer;
	
	_canShoot = true;
	
	Initialize = function() {
		_currentAmmunition = _maxAmmunition;
	}
	
	Shoot = function(position) {
		if(!_canShoot)
			return;
		
		StartCooldown();
		
		var bullet_inst = instance_create_layer(_spawnPoint._x + position._x, _spawnPoint._y + position._y, _layer, _bullet);
		bullet_inst.Initialize(_damage, _direction, _speed, _isPlayer, _sprite, 1.5, true, 1.5);
		_currentAmmunition--;
		
		if(_audioEmitter != noone && _audioId != noone)
			audio_play_sound_on(_audioEmitter, _audioId, false, 3);
	}
	
	StartCooldown = function()  {
        if(_cooldown <= 0)
            return;

        _canShoot = false;
		_timer = time_source_create(time_source_game, _cooldown, time_source_units_seconds, OnCooldownEnd);
		time_source_start(_timer);
    }
	
    OnCooldownEnd = function() {
		_canShoot = true;
	}
	
	isEmpty = function() {
		return (_currentAmmunition <= 0);
	}
}

function TripleMachineGun(isPlayer = true, sprite_ = spr_bullet, bullet = obj_bullet) : Weapon(bullet) constructor {
	var offset = 25;
	_spawnPoint = [ new Vector2(0, -10), new Vector2(offset, 0), new Vector2(-offset, 0)];
	_speed = 70;
	_damage = 1;
	_cooldown = 0.1;
	_direction = new Vector2(0, -1);
	_maxAmmunition = 100;
	_currentAmmunition = _maxAmmunition;
	
	_sprite = sprite_;
	_isPlayer = isPlayer;
	
	_canShoot = true;
	
	Shoot = function(position) {
		if(!_canShoot)
			return;
		
		StartCooldown();
		
		for (var i = 0; i < 3; i++) {
			var bullet_inst = instance_create_layer(_spawnPoint[i]._x + position._x, _spawnPoint[i]._y + position._y, _layer, _bullet);
			bullet_inst.Initialize(_damage, _direction, _speed, _isPlayer, _sprite);
		}
		_currentAmmunition--;
		
		if(_audioEmitter != noone && _audioId != noone)
			audio_play_sound_on(_audioEmitter, _audioId, false, 3);
	}
	
	StartCooldown = function()  {
        if(_cooldown <= 0)
            return;

        _canShoot = false;
		_timer = time_source_create(time_source_game, _cooldown, time_source_units_seconds, OnCooldownEnd);
		time_source_start(_timer);
    }
	
    OnCooldownEnd = function() {
		_canShoot = true;
	}
	
	isEmpty = function() {
		return (_currentAmmunition <= 0);
	}
}