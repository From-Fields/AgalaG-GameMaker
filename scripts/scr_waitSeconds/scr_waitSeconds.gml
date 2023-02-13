// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function WaitSeconds(_time): EnemyAction() constructor{
	_timeout = _time;
	_startTime = 0;
	_timeoutTime = 0;
	
	CheckCondition = function(_target) {
		return get_timer() >= _timeoutTime;	
	}
	OnStart = function(_target) {
		_startTime = get_timer();
		_timeoutTime = _startTime + (_timeout * 1000000);
	}
}