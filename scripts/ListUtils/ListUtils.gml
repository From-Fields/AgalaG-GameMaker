// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ds_list_remove(list, entity) {
		var _index = ds_list_find_index(list, entity);
	
		if(entity != undefined && _index >= 0) 
			ds_list_delete(list, _index);
}


function ds_list_contains(list, value) {
	var _index = ds_list_find_index(list, value);
		
	return _index >= 0;
}