// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Constructor
Create = function (
	enemy,
	startingPoint, startingAction, timeoutAction, actions, 
	onDeath = undefined, drop_ = undefined, onRelease = undefined, timeout = -1
) {
	if(!instance_exists(enemy)){
		enemy = instance_create_layer(0, 0, "Instances", enemy);
		enemy.Reserve();
	}
	enemy_ = enemy;
	_startingPoint = startingPoint;

	_startingAction = startingAction;
	_timeoutAction = timeoutAction;
	_actionCache = ds_queue_create();
	ds_queue_copy(_actionCache, actions);
	
	_drop = drop_;
	
	_onDeath = onDeath;
	_onRelease = onRelease;

	_timeout = timeout;
	
	_onUnitReleased = new EventListener();
}
	
// Methods
Initialize = function() {
	_enemy = enemy_.Pool().Get();
	
	_actions = ds_queue_create();
	ds_queue_copy(_actions, _actionCache);
	
	_enemy.Initialize(_actions, _startingAction, _timeoutAction, _startingPoint, _drop);
	_hasTimedOut = false;
	
	_onUnitReleased = new EventListener();
	
	if(_onDeath != undefined)
		_enemy.onDeath.AddListener(_onDeath);
	if(_onRelease != undefined)
		_enemy.onRelease.AddListener(_onRelease);
		
	_enemy.onRelease.AddListener(OnRelease)

    if(_timeout > 0)
        alarm[0] = room_speed * _timeout;
}
ExecuteTimeoutAction = function() {
    if(_hasTimedOut)
        return;

    _hasTimedOut = true;

    _enemy.ExecuteTimeoutAction();
}
OnRelease = function() {
	 _enemy.onRelease.RemoveListener(OnRelease);
	 _onUnitReleased.Invoke(id);
}
Reserve = function() { return _enemy.Reserve(); }