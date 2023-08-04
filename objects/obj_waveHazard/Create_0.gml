// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Constructor
Create = function (
	hazard,
	startingPoint, direction_,
	maxBounces = 0, waitForTimeout = false, scale_ = new Vector2(1, 1),
	onRelease = undefined, damage_ = 1, health_ = 1, sprite_ = spr_hazard_a, 
	speed_ = 1200, rotationSpeed_ = 150, timeout = -1
) {
	if(!instance_exists(hazard)){
		hazard = instance_create_layer(0, 0, "Instances", hazard);
		hazard.ReserveToPool();
	}
	
	hazard_ = hazard;
	
	_startingPoint = startingPoint;
	
	_direction = direction_;
	_speed = speed_;
	_rotationSpeed = rotationSpeed_;
	_scale = scale_;
	_sprite = sprite_;
	
	_damage = damage_;
	_health = health_;
	_maxBounces = maxBounces;
	
	_waitForTimeout = waitForTimeout;
	
	_onRelease = onRelease;

	_timeout = timeout;
	_timer = undefined;

	_onUnitReleased = new EventListener();
}
	
// Methods
Initialize = function() {
	_hazard = hazard_.Pool().Get();
	
	_hazard.Initialize(
		_startingPoint, _direction, _maxBounces, 
		_health, _damage,
		_speed, true, _rotationSpeed,
		_scale, _sprite
	);

	_onUnitReleased = new EventListener();

	if(_onRelease != undefined)
		_hazard.onRelease.AddListener(onRelease);
		
	_hazard.onRelease.AddListener(OnRelease);
	
	_hasTimedOut = false;
	_timer = undefined;

    if(_waitForTimeout && _timeout > 0)
        alarm[0] = room_speed * _timeout;
	else if(!_waitForTimeout) {
		_timer = time_source_create(time_source_game, 0.5, time_source_units_seconds, OnRelease);
		time_source_start(_timer);
	}
	
	_pause = instance_find(obj_pause_controller, 0);
	_pause.onPause.AddListener(OnPause);
}
ExecuteTimeoutAction = function() {
    if(_hasTimedOut)
        return;

    _hasTimedOut = true;
	
    OnRelease();
}
OnRelease = function() {
	 _hazard.onRelease.RemoveListener(OnRelease);
	 _onUnitReleased.Invoke(id);
}
Reserve = function() { return _hazard.ReserveToPool(); }

OnPause = function(paused) {
	if(_timer == undefined)
		return;
		
	if(paused)
		time_source_pause(_timer);
	else
		time_source_resume(_timer);
}
