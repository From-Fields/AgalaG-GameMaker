/// @description Insert description here
// You can write your code in this editor

if !audio_group_is_loaded(ambient_group) {
    audio_group_load(ambient_group);
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	audio_group_set_gain(ambient_group, global.sfx_volume * master_volume, 0);
}

if !audio_group_is_loaded(sfx_group) {
    audio_group_load(sfx_group);
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	audio_group_set_gain(ambient_group, global.sfx_volume * master_volume, 0);
}

if !audio_group_is_loaded(music_group) {
    audio_group_load(music_group);
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	audio_group_set_gain(ambient_group, global.music_volume * master_volume, 0);
}

if !audio_group_is_loaded(ui_group) {
    audio_group_load(ui_group);
	var master_volume = (global.master_volume > 0) ? ((global.master_volume) / 10) : 0;
	audio_group_set_gain(ambient_group, global.sfx_volume * master_volume, 0);
}

