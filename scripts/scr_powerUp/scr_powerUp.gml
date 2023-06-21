// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PowerUp() constructor{
	_player = undefined
    sprite = undefined;
    isInstant = false;

	//Public Methods
    EndPowerUp = function() {
		OnEnd();
	}
	
	
	// Override Methods
	OnTick = function() { }
    OnTakeDamage = function(damage, playerHealth) {
		return damage;
	}
    OnDeath = function() {
		return true;
	}
	OnPickup = function(player) { }
	OnEnd = function() { }
}