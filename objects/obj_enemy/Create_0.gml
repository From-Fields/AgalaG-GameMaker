/// @description Insert description here
// You can write your code in this editor

event_inherited();
visible = true;
phy_active = true;
phy_fixed_rotation = true;

_score = 0;
_isDead = false;

_defaultSpeed = 500;
_currentSpeed = _defaultSpeed;

_defaultAcceleration = 10;
_currentAcceleration = _defaultAcceleration;

_actionQueue = ds_queue_create();
_startingAction = undefined;
_timeoutAction = undefined;
_currentAction = undefined;

_defaultCollisionDamage = 1;
_collisionDamage = 0;

onRelease = new EventListener();
onDeath = new EventListener();

SubInitialize = function() {}
Initialize = function(actionQueue, startingAction, timeoutAction, position) {
	if(actionQueue == undefined || timeoutAction == undefined)	
		return;
		
	_isDead = false;
	_actionQueue = actionQueue;
	_startingAction = startingAction;
	_timeoutAction = timeoutAction;

	x = position._x;
	y = position._y;
	phy_position_x = position._x;	
	phy_position_y = position._y;	
	phy_active = true;
	visible = true;
	instance_activate_object(id);

	SubInitialize();

	if(startingAction != undefined)
		ExecuteStartingAction();
	else
		ExecuteNextAction();
}

//Action Methods
ExecuteNextAction = function() {
	_newAction = ds_queue_dequeue(_actionQueue);
	if(_newAction != undefined)
		SwitchAction(_newAction);
	else if(_currentAction != _timeoutAction)
		ExecuteTimeoutAction();
	else
		SwitchAction(undefined);		
}
ExecuteStartingAction = function() {
	SwitchAction(_startingAction);	
}
ExecuteTimeoutAction = function() {
	SwitchAction(_timeoutAction);	
}
SwitchAction = function(_nextAction) {
	if(_isDead)
		return;
	
	if(_currentAction != undefined)
		_currentAction.OnFinish(self);
	_currentAction = _nextAction;
	if(_currentAction != undefined)
		_currentAction.OnStart(self);
		
	if(_currentAction == undefined)
		Reserve()
}

//Death Methods
Die = function() {
	onDeath.Invoke(_score);
	Reserve();
}
ReserveToPool = function() {}
SubReserve = function() {}
Reserve = function() {
	_isDead = true;
	
	_actionQueue = ds_queue_create();
	_startingAction = undefined;
	_timeoutAction = undefined;
	_currentAction = undefined;
	
	onDeath.Clear();
	
	phy_active = false;
	visible = false;
	instance_deactivate_object(id);
	
	SubReserve();
	ReserveToPool();
	onRelease.Invoke();
}

//Poolable Implementation
//onGetFromPool = function(obj) { instance_activate_object(obj); }
//onReleaseToPool = function(obj) { }