// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EventListener() constructor{
	_listeners = ds_list_create();
	
	AddListener = function(listener) {
		ds_list_add(_listeners, listener);
	}
	
	RemoveListener = function(listener) {
		var _index = ds_list_find_index(_listeners, listener);
	
		if(listener != noone && _index != 1) {
			ds_list_delete(_listeners, _index);
		}
	}
	Clear = function() {
		ds_list_clear(_listeners);
	}
	
	Invoke = function() {
		var size = ds_list_size(_listeners);
		
		for(i = 0; i < size; i++) {
			var _listener = ds_list_find_value(_listeners, i);
			
			switch(argument_count) {
				case 0:
					_listener(); break;
				case 1:
					_listener(argument0); break;
				case 2:
					_listener(argument0, argument1); break;
				case 3:
					_listener(argument0, argument1, argument2); break;
			}
		}
	}
}