states = {
	mainOptions: "main",
	settings: "settings"
}

state = states.mainOptions;
fullscreen_active = [ false ];

global.master_volume = 10;
global.music_volume = 10;
global.sfx_volume = 10;

master_volume_pos = [ room_width / 2 + 250, room_height / 2];
music_volume_pos = [ room_width / 2 + 250, room_height / 2 + 100];
sfx_volume_pos = [ room_width / 2 + 250, room_height / 2 + 200];

startGame = function() {
	room_goto(Room1);
}

settings = function() {
	state = states.settings;
}

exitGame = function() {
	game_end();
}

fullscreenPressed = function() {
	window_set_fullscreen(!window_get_fullscreen());
}

updateVolume = function() {
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	var music_volume = (global.music_volume > 0) ? (global.music_volume * master_volume) / 10 : 0;
	var sfx_volume = (global.sfx_volume > 0) ? (global.sfx_volume * master_volume) / 10 : 0;
	
	if (audio_group_is_loaded(ambient_group)) {
		audio_group_set_gain(ambient_group, sfx_volume * master_volume * 0.02, 0);
	}
	if (audio_group_is_loaded(sfx_group)) {
		audio_group_set_gain(sfx_group, sfx_volume * master_volume, 0);
	}
	if (audio_group_is_loaded(ui_group)) {
		audio_group_set_gain(ui_group, sfx_volume * master_volume, 0);
	}
	
	if (audio_group_is_loaded(music_group)) {
		audio_group_set_gain(music_group, music_volume * master_volume, 0);
	}
	
}

onChangeMasterVolume = function(volume) {
	global.master_volume = volume;
	updateVolume();
}

onChangeMusicVolume = function(volume) {
	global.music_volume = volume;
	updateVolume();
}

onChangeSFXVolume = function(volume) {
	global.sfx_volume = volume;
	updateVolume();
}