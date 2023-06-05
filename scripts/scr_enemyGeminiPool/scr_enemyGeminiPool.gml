// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EnemyGeminiChildPool() constructor {
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
		return obj_enemy_gemini_child.CreateFunction() 
	}
	onGetAction = function(entity) {
		//show_debug_message("Got")
		return obj_enemy_gemini_child.onGetFromPool(entity) 
	}
	onReleaseAction = function(entity) { 
		//show_debug_message("Released")
		return obj_enemy_gemini_child.onReleaseToPool(entity) 
	}
}