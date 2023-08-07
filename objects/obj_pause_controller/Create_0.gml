/// @description Insert description here
// You can write your code in this editor

_input = new InputHandler().Instance();
_paused = false;
_backgroundId = layer_get_id("Background");
_bgSpeed = layer_get_vspeed(_backgroundId);
show_debug_message(_backgroundId)

onPause = new EventListener();

paused_surf = -1;

TogglePause = function(paused) {
	_paused = paused;
	onPause.Invoke(paused);
	physics_pause_enable(paused);
	
	
	var speed_ = (paused) ? 0 : _bgSpeed;
	layer_vspeed(_backgroundId, speed_);
	
	if(!paused) {
		instance_activate_all();
		surface_free(paused_surf);
	    paused_surf = -1;
	}
}
ResumeGame = function() {
	TogglePause(false);
}
Retry = function() {

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