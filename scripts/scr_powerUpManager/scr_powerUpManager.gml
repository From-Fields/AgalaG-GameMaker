// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PowerUpManager() constructor{
	Instance = function() {
		static _instance = noone;
		
		if(_instance == noone) {
			_instance = new PowerUpManager();
		}
		
		return _instance;
	}
	
	GetRandomPickup = function() {
		static _dropProportions = noone;
		static _dropRates = noone;
		static _nullDropRate = 8;
		
		if(_dropProportions == noone) {
			_dropProportions = GetProportions();
			_dropRates = CalculateRates(_dropProportions, _dropRates, _nullDropRate);
		}
		
		var totalChance = GetTotalChance(_dropProportions, _nullDropRate);
		return GetPickup( _dropRates, _nullDropRate, totalChance);
	}
	GetProportions = function() {
		_dropProportions = ds_map_create();
		ds_map_add(_dropProportions, ShieldPowerUp, 4);
		ds_map_add(_dropProportions, RepairPowerUp, 4);
		ds_map_add(_dropProportions, MissileWeaponPowerUp, 2);
		ds_map_add(_dropProportions, MultishotWeaponPowerUp, 2);
		return _dropProportions;
	}
	CalculateRates = function(_dropProportions, _dropRates, _nullDropRate) {		
		_dropRates = ds_map_create();
		
		var accumulator = _nullDropRate;
		var count = ds_map_size(_dropProportions);
		var keys = ds_map_keys_to_array(_dropProportions);
		
		for(var i = 0; i < count; i++) {
			// show_debug_message(i)
			var key = keys[i];
			var item = ds_map_find_value(_dropProportions, key);
			
			var values = new Vector2(accumulator, accumulator + item)
			accumulator += item;
			
			// show_debug_message(string(key) + ": " + string(values._x) + "-" + string(values._y));
			
			ds_map_add(_dropRates, key, values);
		}
		return _dropRates;
	}
	GetTotalChance = function(_dropRates, _nullDropRate) {
		var count = ds_map_size(_dropRates);
		var values = ds_map_values_to_array(_dropRates);
		var accumulator = _nullDropRate;
		
		for(var i = 0; i < count; i++) {
			var value = values[i];
			accumulator += value;
		}
		
		
		return accumulator;
	}
	GetPickup = function(_dropRates, _nullDropRate, totalChance) {
		var chance = random_range(0, totalChance);
		
		if(chance < _nullDropRate)
			return undefined;
		
		var count = ds_map_size(_dropRates);
		var values = ds_map_values_to_array(_dropRates);
		var keys = ds_map_keys_to_array(_dropRates);
		
		for(var i = 0; i < count; i++) {
			var value = values[i];
			
			if(chance >= value._x && chance < value._y) {
				var key = keys[i];
				var obj = new key();
				
				return obj;
			}
		}
		
		return undefined;
	}
}