/// @description Insert description here
// You can write your code in this editor

event_inherited();
phy_active = true;
phy_fixed_rotation = true;

_score = 0;

_defaultSpeed = 500;
_currentSpeed = _defaultSpeed;

_defaultAcceleration = 10;
_currentAcceleration = _defaultAcceleration;

_actionQueue = ds_queue_create();
_startingAction = undefined;
_timeoutAction = undefined;
_currentAction = undefined;

onDeath = new EventListener();
onRelease = new EventListener();

Initialize = function(actionQueue, startingAction, timeoutAction, position) {
	if(actionQueue == undefined || timeoutAction == undefined)	
		return;
		
	_isDead = false;
	_actionQueue = actionQueue;
	_startingAction = startingAction;
	_timeoutAction = timeoutAction;
		
	x = position._x;	
	y = position._y;	
	visible = true;

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
	onDeath.Invoke();
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
	instance_deactivate_object(id);
}

//Poolable Implementation
onReleaseToPool = function(obj) { obj.OnReserve(); }