// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function HazardPool() constructor {
	Instance = function() {
		static _pool = noone;
		
		if(_pool == noone) {
			_pool = new ObjectPool(
				self
			);
		}
		
		return _pool;
	}

	onCreateFunction = function() { 
		//show_debug_message("Created")
		return instance_create_layer(0, 0, "Instances", obj_hazard);
	}
	onGetAction = function(entity) {
		//show_debug_message("Got")
	}
	onReleaseAction = function(entity) { 
		//show_debug_message("Released")
	}
}