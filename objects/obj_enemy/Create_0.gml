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

_drop = undefined;

onRelease = new EventListener();
onDeath = new EventListener();

_shotSound = noone;
_moveSound = noone;
_deathSound = sfx_death_enemy;
_moveSoundInstance = noone;

SubInitialize = function() {}
Initialize = function(actionQueue, startingAction, timeoutAction, position, drop_ = undefined) {
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

	_drop = drop_;

	SubInitialize();

	if(_moveSound != noone)
		_moveSoundInstance = audio_play_sound_on(_audioEmitter, _moveSound, true, 0);

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
	
    if(_drop != undefined) {
        var randomX = random_range(-1, 1);
        var randomY = random_range(-1, 1);;

		var randomDirection = new Vector2(randomX, randomY);
        randomDirection.Normalize();
		
		var position = new Vector2(phy_position_x, phy_position_y);

        new PickUpPool().Instance().Get().Initialize(_drop, position, randomDirection);
    }

	if(_moveSoundInstance != noone)
		audio_stop_sound(_moveSoundInstance);
	if(_deathSound != noone)
		audio_play_sound_on(_audioEmitter, _deathSound, false, 0);
	
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