// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EventListener() constructor{
	listeners = ds_list_create();
	
	AddListener = function(listener) {
		ds_list_add(listeners, listener);
	}
	
	RemoveListener = function(listener) {
		var _index = ds_list_find_index(listeners, listener);
	
		if(listener != noone && _index != 1) {
			ds_list_delete(listeners, _index);
		}
	}
	Clear = function() {
		ds_list_clear(listeners);
	}
	
	Invoke = function(arg) {
		var size = ds_list_size(listeners);
		
		for(i = 0; i < size; i++) {
			listeners[i](arg);	
		}
	}
}