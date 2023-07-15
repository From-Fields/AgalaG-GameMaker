// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function RepairPowerUp(): PowerUp() constructor{
	sprite = spr_powerup_repair;
	isInstant = true;
	
	OnPickup = function(player) {
		player.Heal(player._maxHealth);
	}
}