// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GameWaves() constructor {
	GetLevel = function(onDeath) {
		return new EndlessLevel(CreateWaves(onDeath));
	}

	CreateWaves = function(onDeath) {
		static waves = ds_list_create();
		
		var width = room_width, height = room_height;
		
		var doubleKami = new DoubleKami(onDeath, width, height)._controller;
		var bumbleTrouble = new BumbleTrouble(onDeath, width, height)._controller;	
	
		//ds_list_add(waves, doubleKami);
		ds_list_add(waves, bumbleTrouble);

		return waves;
	}
}

function Wave(timeout_) constructor {
	_timeout = timeout_;
	_list = undefined;
	_controller = undefined;
}

function DoubleKami(onDeath_, width, height): Wave(6) constructor {
	_list = ds_list_create();
	
	var actionQueue_a = ds_queue_create();
	ds_queue_enqueue(actionQueue_a, new WaitSeconds(2));
	
	var unit_a = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_a.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.25, -height * 0.2),
        new MoveTowards(new Vector2(width * 0.2, height * 0.25)),
        new MoveTowards(new Vector2(width * 0.45, height * 1.1), 4),
        actionQueue_a,
        onDeath_
    );
    var unit_b = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_b.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.75, -height * 0.2),
        new MoveTowards(new Vector2(width * 0.8, height * 0.25)),
        new MoveTowards(new Vector2(width * 0.55, height * 1.1), 4),
        actionQueue_a,
        onDeath_
    );
    var unit_c = instance_create_layer(0, 0, "Controller", obj_waveHazard);
	unit_c.Create(new Vector2(-width * 0.2, height / 2), new Vector2(2, -0.75), 5);
	
    var unit_d = instance_create_layer(0, 0, "Controller", obj_waveHazard);
	unit_d.Create(new Vector2(width * 1.2, height / 2), new Vector2(-2, -1), 5);
	
	ds_list_add(_list, unit_a);
	ds_list_add(_list, unit_b);
	ds_list_add(_list, unit_c);
	ds_list_add(_list, unit_d);
	
	var controller = instance_create_layer(0, 0, "Controller", obj_waveController);
	controller.Create(_timeout, _list);
	
	_controller = controller;
}

function BumbleTrouble(onDeath_, width, height): Wave(8) constructor {
	_list = ds_list_create();
	
	var actionQueue_a = ds_queue_create();
	ds_queue_enqueue(actionQueue_a, new MoveTowards(new Vector2(width * 0.5, height * 0.3)));
	ds_queue_enqueue(actionQueue_a, new ShootInSeconds(3));
	ds_queue_enqueue(actionQueue_a, new MoveAndShoot(new Vector2(width * 0.5, height * 0.6)));
	
	var unit_a = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_a.Create
    (
		obj_enemy_bumblebee,
        new Vector2(width * 0.5, -height * 0.2),
        new WaitSeconds(1),
        new MoveTowards(new Vector2(-width*0.2, height * 0.6), 4),
        actionQueue_a,
        onDeath_
    );
	
	var actionQueue_b = ds_queue_create();
	ds_queue_enqueue(actionQueue_b, new MoveAndShoot(new Vector2(width * 0.4, height * 0.1)));
	ds_queue_enqueue(actionQueue_b, new MoveAndShoot(new Vector2(width * 0.6, height * 0.1)));
	ds_queue_enqueue(actionQueue_b, new MoveAndShoot(new Vector2(width * 0.8, height * 0.2)));
	ds_queue_enqueue(actionQueue_b, new MoveAndShoot(new Vector2(width * 0.5, height * 0.4)));
	ds_queue_enqueue(actionQueue_b, new MoveAndShoot(new Vector2(width * 0.15, height * 0.2)));
	
	var unit_b = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	unit_b.Create
    (
		obj_enemy_bumblebee,
        new Vector2(width * 0.2, -height * 0.2),
        new MoveTowards(new Vector2(width * 0.2, height * 0.2)),
        new MoveTowards(new Vector2(width * 0.5, height * 1.2), 4, 1, 5, 360, 40, true, 80, false),
        actionQueue_b,
        onDeath_
    );
	
	ds_list_add(_list, unit_a);
	ds_list_add(_list, unit_b);
	
	var controller = instance_create_layer(0, 0, "Controller", obj_waveController);
	controller.Create(_timeout, _list);
	
	_controller = controller;
}
