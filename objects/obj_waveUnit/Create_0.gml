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
	
	_enemy = enemy.Pool().Get();
	_startingPoint = startingPoint;

	_startingAction = startingAction;
	_timeoutAction = timeoutAction;
	_actions = actions;
	
	_drop = drop_;
	
	_onUnitReleased = new EventListener();

	if(onDeath != undefined)
		_enemy.onDeath.AddListener(onDeath);
	if(onRelease != undefined)
		_enemy.onRelease.AddListener(onRelease);
		
	_enemy.onRelease.AddListener(OnRelease)

	_timeout = timeout;
	_hasTimedOut = false;
}
	
// Methods
Initialize = function() {
	_enemy.Initialize(_actions, _startingAction, _timeoutAction, _startingPoint, _drop);
	

    if(_timeout > 0)
        alarm[0] = room_speed * _timeout;
}
ExecuteTimeoutAction = function() {
    if(_hasTimedOut)
        return;

    _hasTimedOut = true;

    _enemy.ExecuteTimeoutAction();
}
Reserve = function() { return _enemy.Reserve(); }