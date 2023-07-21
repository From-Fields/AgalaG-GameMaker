/// @description Sound Loaded
if (audio_group_is_loaded(ambient_group)) {
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	var sfx_volume = (global.sfx_volume > 0) ? (global.sfx_volume * master_volume) / 10 : 0;
	audio_group_set_gain(ambient_group, sfx_volume * master_volume * 0.02, 0);
}

if (audio_group_is_loaded(sfx_group)) {
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	var sfx_volume = (global.sfx_volume > 0) ? (global.sfx_volume * master_volume) / 10 : 0;
	audio_group_set_gain(ambient_group, sfx_volume * master_volume, 0);
}

if (audio_group_is_loaded(music_group)) {
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	var music_volume = (global.music_volume > 0) ? (global.sfx_volume * master_volume) / 10 : 0;
	audio_group_set_gain(ambient_group, music_volume * master_volume, 0);
}

if (audio_group_is_loaded(ui_group)) {
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	var sfx_volume = (global.sfx_volume > 0) ? (global.sfx_volume * master_volume) / 10 : 0;
	show_debug_message("sfx volume: " + string(sfx_volume * master_volume))
	audio_group_set_gain(ambient_group, sfx_volume * master_volume, 0);
}