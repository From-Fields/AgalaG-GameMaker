/// @description Insert description here
// You can write your code in this editor

points = 0;

CreateWave = function()
{
    wave = instance_create_layer(0, 0, "Controller", obj_waveController);
	
	unitList = ds_list_create();
	
	queueA = ds_queue_create();
	ds_queue_enqueue(queueA, new MoveTowards(new Vector2(150, 450), 1.5, 1, 0.8));
	unitA = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	unitA.Create(
		obj_enemy_kamikaze,
		new Vector2(300, -60),
        new MoveTowards(new Vector2(300, 300), 0.7),
        new MoveTowards(new Vector2(-60, 350), 1.5),
		queueA,
		LogScore
	);
	
	queueB = ds_queue_create();
	ds_queue_enqueue(queueB, new MoveTowards(new Vector2(1366 - 150, 450), 1.5, 1, 0.8));
	unitB = instance_create_layer(0, 0, "Controller", obj_waveUnit);
	unitB.Create(
		obj_enemy_gemini,
		new Vector2(1366 - 300, -60),
        new MoveAndShoot(new Vector2(1366 - 300, 300), 0.7),
        new MoveTowards(new Vector2(1366 + 60, 350), 1.5),
		queueB,
		LogScore
	);
	
	hazardA = instance_create_layer(0, 0, "Controller", obj_waveHazard);
	hazardA.Create(
		obj_hazard,
		new Vector2(1366 - 300, -200), 
		new Vector2(-0.3, 1), 
		3, true
	)
	
	ds_list_add(unitList, unitA);
	ds_list_add(unitList, unitB);
	ds_list_add(unitList, hazardA);

	wave.Create(10, unitList);

    wave.Initialize();

    wave._onWaveDone.AddListener(CreateWave);
}

LogScore = function(_score) {
	points += _score;
	show_debug_message(string(points));
}

CreateWave();