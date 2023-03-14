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

onRelease = new EventListener();
onDeath = new EventListener();

Initialize = function(actionQueue, startingAction, timeoutAction, position) {
	if(actionQueue == undefined || timeoutAction == undefined)	
		return;
		
	_isDead = false;
	_actionQueue = actionQueue;
	_startingAction = startingAction;
	_timeoutAction = timeoutAction;

	phy_position_x = position._x;	
	phy_position_y = position._y;	
	phy_active = true;
	visible = true;
	instance_activate_object(id);


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
Reserve = function() { }
OnReserve = function() {
	_isDead = true;
	onRelease.Invoke();
	
	_actionQueue = ds_queue_create();
	_startingAction = undefined;
	_timeoutAction = undefined;
	_currentAction = undefined;
	
	onDeath.Clear();
	onRelease.Clear();
	
	phy_active = false;
	visible = false;
	instance_deactivate_object(id);
}

//Poolable Implementation
//onGetFromPool = function(obj) { instance_activate_object(obj); }
onReleaseToPool = function(obj) { obj.OnReserve(); }