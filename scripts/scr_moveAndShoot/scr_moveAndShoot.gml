// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MoveAndShoot(
	target, 
	speedMultiplier = 1, accelerationMultiplier = 1, steeringSpeed = 1, 
	maximumAngle = 360, minimumDistance = 5, decelerate = true, decelerationRadius = 20, stopOnEnd = true
): MoveTowards(
	target, speedMultiplier, accelerationMultiplier, 
	steeringSpeed,	maximumAngle, minimumDistance, 
	decelerate, decelerationRadius, stopOnEnd
) constructor {
	_parentUpdate = Update;
	
	Update = function(_target) 
    {
		_parentUpdate(_target);
        _target.Shoot();
	}
}