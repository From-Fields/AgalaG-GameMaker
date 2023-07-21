/// @description Insert description here
// You can write your code in this editor

if !audio_group_is_loaded(ambient_group) {
    audio_group_load(ambient_group);
}

if !audio_group_is_loaded(sfx_group) {
    audio_group_load(sfx_group);
}

if !audio_group_is_loaded(music_group) {
    audio_group_load(music_group);
}

if !audio_group_is_loaded(ui_group) {
    audio_group_load(ui_group);
}

