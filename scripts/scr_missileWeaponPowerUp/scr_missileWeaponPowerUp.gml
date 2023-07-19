// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MissileWeaponPowerUp(): PowerUp() constructor{
	sprite = spr_missile;
	isInstant = true;
	
	OnPickup = function(player) {
		player.SwitchWeapon(new MissileWeapon());
	}
}