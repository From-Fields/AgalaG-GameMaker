// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ShieldPowerUp(): PowerUp() constructor{
	sprite = spr_powerup_shield;
	isInstant = false;
	
	_damageSound = sfx_dmg_shield;
	
	OnPickup = function(player) {
		_player = player;
	}
	OnTakeDamage = function(damage, playerHealth) {
        if(damage <= 0)
            return damage;
		
		audio_play_sound_on(_player._audioEmitter, _damageSound, false, 5);

        EndPowerUp();
        return damage - 1;
    }
    OnEnd = function() {
        _player.RemovePowerUp(self);
    }
}