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
		var geminiSentry = new GeminiSentry(onDeath, width, height)._controller;
		var asteroidClock = new AsteroidClock(width, height)._controller;
		var flyByNight = new FlyByNight(onDeath, width, height)._controller;
		var symmetry = new Symmetry(onDeath, width, height)._controller;
		var tsuKami = new TsuKami(onDeath, width, height)._controller;
		var pincerBlow = new PincerBlow(onDeath, width, height)._controller;

		//ds_list_add(waves, doubleKami);
		//ds_list_add(waves, bumbleTrouble);
		//ds_list_add(waves, geminiSentry);
		//ds_list_add(waves, asteroidClock);
		//ds_list_add(waves, flyByNight);
		//ds_list_add(waves, symmetry);
		//ds_list_add(waves, tsuKami);
		ds_list_add(waves, pincerBlow);

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

function GeminiSentry(onDeath_, width, height): Wave(9) constructor {
	_list = ds_list_create();
	
	var actionQueue_a = ds_queue_create();
	ds_queue_enqueue(actionQueue_a, new ShootInSeconds(8));
	
	var unit_a = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_a.Create
    (
		obj_enemy_gemini,
        new Vector2(width * 0.5, -height * 0.2),
        new MoveTowards(new Vector2(width*0.5, height * 0.2)),
        new MoveTowards(new Vector2(width*0.5, -height * 0.2)),
        actionQueue_a,
        onDeath_
    );
	
	var actionQueue_b = ds_queue_create();
	ds_queue_enqueue(actionQueue_b, new MoveTowards(new Vector2(width*0.25, height * 0.3)));
	ds_queue_enqueue(actionQueue_b, new ShootInSeconds(2));
	
	var unit_b = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	unit_b.Create
    (
		obj_enemy_bumblebee,
        new Vector2(-width * 0.1, -height * 0.2),
        new WaitSeconds(1),
        new MoveAndShoot(new Vector2(width * 1.2, height * 1)),
        actionQueue_b,
        onDeath_
    );
	
	var actionQueue_c = ds_queue_create();
	ds_queue_enqueue(actionQueue_c, new MoveTowards(new Vector2(width*0.75, height * 0.2)));
	ds_queue_enqueue(actionQueue_c, new ShootInSeconds(2));
	
	var unit_c = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	unit_c.Create
    (
		obj_enemy_bumblebee,
        new Vector2(width * 1.1, -height * 0.2),
        new WaitSeconds(1),
        new MoveAndShoot(new Vector2(-width * 0.2, height * 1)),
        actionQueue_c,
        onDeath_
    );
	
	ds_list_add(_list, unit_a);
	ds_list_add(_list, unit_b);
	ds_list_add(_list, unit_c);
	
	var controller = instance_create_layer(0, 0, "Controller", obj_waveController);
	controller.Create(_timeout, _list);
	
	_controller = controller;
}

function AsteroidClock(width, height): Wave(0) constructor {
	_list = ds_list_create();

	
    var unit_a = instance_create_layer(0, 0, "Controller", obj_waveHazard);
	unit_a.Create(new Vector2(width * 1.1, height * 0.9), new Vector2(-0.75, -0.75), 9);
	
    var unit_b = instance_create_layer(0, 0, "Controller", obj_waveHazard);
	unit_b.Create(new Vector2(width * 0.7, -height * 0.6), new Vector2(-0.25, 1.25), 7);
	
    var unit_c = instance_create_layer(0, 0, "Controller", obj_waveHazard);
	unit_c.Create(new Vector2(-width * 0.4, height * 0.1), new Vector2(1, 0.25), 5);
	
    var unit_d = instance_create_layer(0, 0, "Controller", obj_waveHazard);
	unit_d.Create(new Vector2(-width * 0.2, height * 1.9), new Vector2(0.75, -1.5), 10);
	
	ds_list_add(_list, unit_a);
	ds_list_add(_list, unit_b);
	ds_list_add(_list, unit_c);
	ds_list_add(_list, unit_d);
	
	var controller = instance_create_layer(0, 0, "Controller", obj_waveController);
	controller.Create(_timeout, _list);
	
	_controller = controller;
}

function FlyByNight(onDeath_, width, height): Wave(15) constructor {

	_list = ds_list_create();
	
	var actionQueue_a = ds_queue_create();
	ds_queue_enqueue(actionQueue_a, new MoveTowards(new Vector2(width * 0.8, height * 0.3)));
	ds_queue_enqueue(actionQueue_a, new ShootInSeconds(4));
	
	var unit_a = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_a.Create
    (
		obj_enemy_gemini,
        new Vector2(width * 0.2, -height * 0.2),
        new WaitSeconds(1),
        new MoveAndShoot(new Vector2(-width * 0.2, height * 0.8)),
        actionQueue_a,
        onDeath_
    );
	
	var actionQueue_b = ds_queue_create();
	ds_queue_enqueue(actionQueue_b, new MoveTowards(new Vector2(width * 0.2, height * 0.3)));
	ds_queue_enqueue(actionQueue_b, new ShootInSeconds(3));
	
	var unit_b = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_b.Create
    (
		obj_enemy_gemini,
        new Vector2(width * 1.2, -height * 0.2),
        new WaitSeconds(2),
        new MoveAndShoot(new Vector2(width * 1.2, height * 0.8)),
        actionQueue_b,
        onDeath_
    );
	
	var actionQueue_c = ds_queue_create();
	ds_queue_enqueue(actionQueue_c, new ShootInSeconds(1));
	
	var unit_c = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_c.Create
    (
		obj_enemy_bumblebee,
        new Vector2(-width * 0.1, height * 0.25),
        new MoveTowards(new Vector2(width * 0.15, height * 0.25)),
        new MoveAndShoot(new Vector2(width * 1.2, height * 0.25)),
        actionQueue_c,
        onDeath_
    );
	
	var actionQueue_d = ds_queue_create();
	ds_queue_enqueue(actionQueue_d, new ShootInSeconds(1));
	
	var unit_d = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_d.Create
    (
		obj_enemy_bumblebee,
        new Vector2(width * 1.1, height * 0.4),
        new MoveTowards(new Vector2(width * 0.85, height * 0.4)),
        new MoveAndShoot(new Vector2(-width * 0.2, height * 0.4)),
        actionQueue_d,
        onDeath_
    );

	ds_list_add(_list, unit_a);
	ds_list_add(_list, unit_b);
	ds_list_add(_list, unit_c);
	ds_list_add(_list, unit_d);
	
	var controller = instance_create_layer(0, 0, "Controller", obj_waveController);
	controller.Create(_timeout, _list);
	
	_controller = controller;
}

function Symmetry(onDeath_, width, height): Wave(15) constructor {
	_list = ds_list_create();
	
	var actionQueue_a = ds_queue_create();
	ds_queue_enqueue(actionQueue_a, new MoveTowards(new Vector2(width * 0.25, height * 0.6), 4, 1, 5, 360, 40, true, 80, false));
	ds_queue_enqueue(actionQueue_a, new MoveTowards(new Vector2(width * 0.35, height * 0.4), 1, 1, 5, 360, 40, true, 80, false));
	
	var unit_a = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_a.Create
    (
		obj_enemy_kamikaze,
        new Vector2(-width * 0.1, height * 0.8),
        new MoveTowards(new Vector2(width * 0.1, height * 0.15), 1, 1, 5, 360, 40, true, 80, false),
        new MoveTowards(new Vector2(width * 0.15, height * 1.1), 4),
        actionQueue_a,
        onDeath_
    );
	
	var actionQueue_b = ds_queue_create();
	ds_queue_enqueue(actionQueue_b, new MoveTowards(new Vector2(width * 0.75, height * 0.6), 4, 1, 5, 360, 40, true, 80, false));
	ds_queue_enqueue(actionQueue_b, new MoveTowards(new Vector2(width * 0.65, height * 0.4), 1, 1, 5, 360, 40, true, 80, false));
	
	var unit_b = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_b.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 1.1, height * 0.8),
        new MoveTowards(new Vector2(width * 0.9, height * 0.15), 1, 1, 5, 360, 40, true, 80, false),
        new MoveTowards(new Vector2(width * 0.85, height * 1.1), 4),
        actionQueue_b,
        onDeath_
    );
	
	var actionQueue_c = ds_queue_create();
	ds_queue_enqueue(actionQueue_c, new MoveAndShoot(new Vector2(width * 0.5, height * 0.15), 1, 1, 5, 360, 40, true, 80, false));
	ds_queue_enqueue(actionQueue_c, new MoveAndShoot(new Vector2(width * 0.25, height * 0.15), 1, 1, 5, 360, 40, true, 80, false));
	ds_queue_enqueue(actionQueue_c, new MoveAndShoot(new Vector2(width * 0.75, height * 0.15), 1, 1, 5, 360, 40, true, 80, false));
	
	var unit_c = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_c.Create
    (
		obj_enemy_bumblebee,
        new Vector2(width * 0.5, -height * 0.1),
        new WaitSeconds(0.5),
        new MoveTowards(new Vector2(width * 0.5, -height * 0.1)),
        actionQueue_c,
        onDeath_
    );
	
	ds_list_add(_list, unit_a);
	ds_list_add(_list, unit_b);
	ds_list_add(_list, unit_c);
	
	var controller = instance_create_layer(0, 0, "Controller", obj_waveController);
	controller.Create(_timeout, _list);
	
	_controller = controller;
}

function TsuKami(onDeath_, width, height): Wave(15) constructor {
	_list = ds_list_create();
	
	var tsuKamiWait = 2.5;
	
	var actionQueue_a = ds_queue_create();
	ds_queue_enqueue(actionQueue_a, new MoveTowards(new Vector2(width * 0.05, height * 0.1)));
	ds_queue_enqueue(actionQueue_a, new WaitSeconds(tsuKamiWait));
	
	var unit_a = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_a.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.05, -height * 0.2),
        new WaitSeconds(0),
        new MoveTowards(new Vector2(width * 0.05, height * 1.1), 4),
        actionQueue_a,
        onDeath_
    );	
	
	var actionQueue_b = ds_queue_create();
	ds_queue_enqueue(actionQueue_b, new MoveTowards(new Vector2(width * 0.95, height * 0.1)));
	ds_queue_enqueue(actionQueue_b, new WaitSeconds(tsuKamiWait));
	
	var unit_b = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_b.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.95, -height * 0.2),
        new WaitSeconds(0.5),
        new MoveTowards(new Vector2(width * 0.95, height * 1.1), 4),
        actionQueue_b,
        onDeath_
    );	
	
	var actionQueue_c = ds_queue_create();
	ds_queue_enqueue(actionQueue_c, new MoveTowards(new Vector2(width * 0.2, height * 0.1)));
	ds_queue_enqueue(actionQueue_c, new WaitSeconds(tsuKamiWait));
	
	var unit_c = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_c.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.2, -height * 0.2),
        new WaitSeconds(1),
        new MoveTowards(new Vector2(width * 0.2, height * 1.1), 4),
        actionQueue_c,
        onDeath_
    );
	
	var actionQueue_d = ds_queue_create();
	ds_queue_enqueue(actionQueue_d, new MoveTowards(new Vector2(width * 0.8, height * 0.1)));
	ds_queue_enqueue(actionQueue_d, new WaitSeconds(tsuKamiWait));
	
	var unit_d = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_d.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.8, -height * 0.2),
        new WaitSeconds(1.5),
        new MoveTowards(new Vector2(width * 0.8, height * 1.1), 4),
        actionQueue_d,
        onDeath_
    );
	
	var actionQueue_e = ds_queue_create();
	ds_queue_enqueue(actionQueue_e, new MoveTowards(new Vector2(width * 0.35, height * 0.1)));
	ds_queue_enqueue(actionQueue_e, new WaitSeconds(tsuKamiWait));
	
	var unit_e = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_e.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.35, -height * 0.2),
        new WaitSeconds(2),
        new MoveTowards(new Vector2(width * 0.35, height * 1.1), 4),
        actionQueue_e,
        onDeath_
    );
	
	var actionQueue_f = ds_queue_create();
	ds_queue_enqueue(actionQueue_f, new MoveTowards(new Vector2(width * 0.65, height * 0.1)));
	ds_queue_enqueue(actionQueue_f, new WaitSeconds(tsuKamiWait));
	
	var unit_f = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_f.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.65, -height * 0.2),
        new WaitSeconds(2.5),
        new MoveTowards(new Vector2(width * 0.65, height * 1.1), 4),
        actionQueue_f,
        onDeath_
    );
	
	var actionQueue_g = ds_queue_create();
	ds_queue_enqueue(actionQueue_g, new MoveTowards(new Vector2(width * 0.5, height * 0.1)));
	ds_queue_enqueue(actionQueue_g, new WaitSeconds(tsuKamiWait));
	
	var unit_g = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_g.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.5, -height * 0.2),
        new WaitSeconds(3),
        new MoveTowards(new Vector2(width * 0.5, height * 1.1), 4),
        actionQueue_g,
        onDeath_
    );

	ds_list_add(_list, unit_a);
	ds_list_add(_list, unit_b);
	ds_list_add(_list, unit_c);
	ds_list_add(_list, unit_d);
	ds_list_add(_list, unit_e);
	ds_list_add(_list, unit_f);
	ds_list_add(_list, unit_g);
	
	var controller = instance_create_layer(0, 0, "Controller", obj_waveController);
	controller.Create(_timeout, _list);
	
	_controller = controller;
}

function PincerBlow(onDeath_, width, height): Wave(15) constructor {
	_list = ds_list_create();

	var actionQueue_a = ds_queue_create();
	ds_queue_enqueue(actionQueue_a, new MoveTowards(new Vector2(width * 0.05, height * 0.1)));
	ds_queue_enqueue(actionQueue_a, new WaitSeconds(1.5));
	
	var unit_a = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_a.Create
    (
		obj_enemy_kamikaze,
        new Vector2(-width * 0.05, -height * 0.2),
        new WaitSeconds(1),
        new MoveTowards(new Vector2(width * 0.55, height * 1.1), 4),
        actionQueue_a,
        onDeath_
    );
	
	var actionQueue_b = ds_queue_create();
	ds_queue_enqueue(actionQueue_b, new MoveTowards(new Vector2(width * 0.15, height * 0.1)));
	ds_queue_enqueue(actionQueue_b, new WaitSeconds(1));
	
	var unit_b = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_b.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.05, -height * 0.2),
        new WaitSeconds(1.5),
        new MoveTowards(new Vector2(width * 0.65, height * 1.1), 4),
        actionQueue_b,
        onDeath_
    );	
	
	var actionQueue_c = ds_queue_create();
	ds_queue_enqueue(actionQueue_c, new MoveTowards(new Vector2(width * 0.25, height * 0.1)));
	ds_queue_enqueue(actionQueue_c, new WaitSeconds(0.5));
	
	var unit_c = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_c.Create
    (
		obj_enemy_kamikaze,
        new Vector2(width * 0.15, -height * 0.2),
        new WaitSeconds(2),
        new MoveTowards(new Vector2(width * 0.75, height * 1.1), 4),
        actionQueue_c,
        onDeath_
    );	
	
	var actionQueue_d = ds_queue_create();
	ds_queue_enqueue(actionQueue_d, new MoveTowards(new Vector2(width * 0.55, height * 0.15)));
	ds_queue_enqueue(actionQueue_d, new ShootInSeconds(3.6));
	
	var unit_d = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_d.Create
    (
		obj_enemy_bumblebee,
        new Vector2(width * 0.55, -height * 0.1),
        new WaitSeconds(0.3),
        new MoveTowards(new Vector2(width * 0.25, height * 1.1), 4),
        actionQueue_d,
        onDeath_
    );	
	
	var actionQueue_e = ds_queue_create();
	ds_queue_enqueue(actionQueue_e, new MoveTowards(new Vector2(width * 0.75, height * 0.15)));
	ds_queue_enqueue(actionQueue_e, new ShootInSeconds(3.3));
	
	var unit_e = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_e.Create
    (
		obj_enemy_bumblebee,
        new Vector2(width * 0.75, -height * 0.1),
        new WaitSeconds(0.6),
        new MoveTowards(new Vector2(width * 0.45, height * 1.1), 4),
        actionQueue_e,
        onDeath_
    );	
	
	var actionQueue_f = ds_queue_create();
	ds_queue_enqueue(actionQueue_f, new MoveTowards(new Vector2(width * 0.95, height * 0.15)));
	ds_queue_enqueue(actionQueue_f, new ShootInSeconds(3));
	
	var unit_f = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	
	unit_f.Create
    (
		obj_enemy_bumblebee,
        new Vector2(width * 0.95, -height * 0.1),
        new WaitSeconds(0.9),
        new MoveTowards(new Vector2(width * 0.65, height * 1.1), 4),
        actionQueue_f,
        onDeath_
    );	

	ds_list_add(_list, unit_a);
	ds_list_add(_list, unit_b);
	ds_list_add(_list, unit_c);
	ds_list_add(_list, unit_d);
	ds_list_add(_list, unit_e);
	ds_list_add(_list, unit_f);
	
	var controller = instance_create_layer(0, 0, "Controller", obj_waveController);
	controller.Create(_timeout, _list);
	
	_controller = controller;
}