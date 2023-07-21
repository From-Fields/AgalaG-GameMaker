damage = 1;

_audioEmitter = audio_emitter_create();
_audioClip = sfx_explosion;

image_xscale = .75;
image_yscale = image_xscale;

audio_play_sound_on(_audioEmitter, _audioClip, false, 6);

expand = function() {
	image_xscale += .003;
	image_yscale = image_xscale;
}
