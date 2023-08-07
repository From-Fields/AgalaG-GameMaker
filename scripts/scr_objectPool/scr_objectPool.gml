// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ObjectPool(
	fHolder, 
	maxCapacity = 10000, initialCap = 0
) constructor {
	_maxCapacity = maxCapacity;
	
	_activeList = ds_list_create();
	_inactiveQueue = ds_queue_create();
	_inactiveList = ds_list_create();
	
	_functionHolder = fHolder;
	
	for(i = 0; i < initialCap; i++)
		Populate();
	
	CountActive = function() { return ds_list_size(_activeList); }
	CountInactive = function() { return ds_queue_size(_inactiveQueue); }
	CountTotal = function() { return CountActive() + CountInactive(); }
	
	Get = function() {
		if(ds_queue_empty(_inactiveQueue))
			Populate();
			
		var entity = ds_queue_dequeue(_inactiveQueue);
		ds_list_add(_activeList, entity);
		ds_list_remove(_inactiveList, entity);
		
		_functionHolder.onGetAction(entity);
		
		//show_debug_message("Active: " + string(CountActive()));
		//show_debug_message("Inactive: " + string(CountInactive()));
			
		return entity;
	}
	
	Release = function(entity) {
		if(ds_list_contains(_inactiveList, entity))
			throw("Tried to release an item which is already released.");
			
		_functionHolder.onReleaseAction(entity);
		
		ds_queue_enqueue(_inactiveQueue, entity);
		ds_list_add(_inactiveList, entity);
		ds_list_remove(_activeList, entity);
		
		//show_debug_message("Active: " + string(CountActive()));
		//show_debug_message("Inactive: " + string(CountInactive()));
	}
	
	Populate = function() {
        if(CountTotal >= _maxCapacity)
            return;

        var newEntity = _functionHolder.onCreateFunction();

        if(newEntity == undefined)
            throw ("OnCreate returning null.");

         Release(newEntity);
    }
	
	Clear = function() {
		ds_list_clear(_activeList);
		ds_list_clear(_inactiveList);
		ds_queue_clear(_inactiveQueue);
	}
}