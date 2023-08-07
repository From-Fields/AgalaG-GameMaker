show = false;

Retry = function() {
	room_restart();
}

QuitToMenu = function() {
	new EnemyBumblebeePool().Instance().Clear();
	new EnemyGeminiChildPool().Instance().Clear();
	new EnemyGeminiPool().Instance().Clear();
	new EnemyKamikazePool().Instance().Clear();
	new HazardPool().Instance().Clear();
	new PickUpPool().Instance().Clear();
	
	room_goto(MainMenu);	
}