/// @description Insert description here
// You can write your code in this editor

// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
Create = function(timeout, unitList){
	_isDone = false;
	_timeout = timeout;

	_onWaveDone = new EventListener();
	
	_unitCache = ds_list_create();
	ds_list_copy(_unitCache, unitList);
}

Initialize = function() {
	_isDone = false;
	_unitList = ds_list_create();
	ds_list_copy(_unitList, _unitCache);

	_onWaveDone = new EventListener();
	
	var _count = ds_list_size(_unitList);
		
	for(i = 0; i < _count; i++) {
		var _unit = ds_list_find_value(_unitList, i);
			
		_unit.Initialize();
		_unit._onUnitReleased.AddListener(RemoveUnitFromWave);
	}

	alarm[0] = room_speed * _timeout;
}
RemoveUnitFromWave = function(unit) {
    ds_list_remove(_unitList, unit);
	
	unit._onUnitReleased.RemoveListener(RemoveUnitFromWave);

    if(ds_list_empty(_unitList))
    {
		_onWaveDone.Invoke();
        _isDone = true;
		
		alarm[0] = -1;
		alarm[1] = -1;
    }
}
TimeOutAllUnits = function() {
		
	var _count = ds_list_size(_unitList);
		
	for(i = 0; i < _count; i++) {
		var _unit = ds_list_find_value(_unitList, i);
			
		_unit.ExecuteTimeoutAction();			
	}
            
    alarm[1] = room_speed * _timeout / 2;
}
EliminateAllUnits = function() {
	var _count = ds_list_size(_unitCache);
	
	for(i = 0; i < _count; i++) {
		if(_isDone)
			return;
			
		var _unit = ds_list_find_value(_unitCache, i);
		_unit.Reserve();			
	}
}

