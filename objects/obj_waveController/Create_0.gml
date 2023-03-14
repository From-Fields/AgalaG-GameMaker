/// @description Insert description here
// You can write your code in this editor

// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
Create = function(timeout, unitList){
	_isDone = false;
	_timeout = timeout;
	_unitList = unitList;

	_onWaveDone = new EventListener();
}

Initialize = function() {
	var _count = ds_list_size(_unitList);
		
	for(i = 0; i < _count; i++) {
		var _unit = ds_list_find_value(_unitList, i);
			
		_unit._onUnitReleased.AddListener(RemoveUnitFromWave);
		_unit.Initialize();
	}

	alarm[0] = room_speed * _timeout;
}
RemoveUnitFromWave = function(unit) {
    ds_list_remove(_unitList, unit);

    if(ds_list_empty(_unitList))
    {
        _onWaveDone.Invoke();
        _isDone = true;
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
	var _count = ds_list_size(_unitList);
	
	for(i = 0; i < _count; i++) {
		if(_isDone)
			return;
			
		var _unit = ds_list_find_value(_unitList, i);
		_unit.Reserve();			
	}
}

