// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MoveTowards(
	target, 
	speedMultiplier = 1, accelerationMultiplier = 1, steeringSpeed = 1, 
	maximumAngle = 360, minimumDistance = 5, decelerate = true, decelerationRadius = 50, stopOnEnd = true
): EnemyAction() constructor{
	if(typeof(target) != "struct"){
		_targetObject = target;
		_targetPosition = new Vector2(target.x, target.y);
	}
	else {
		_targetObject = noone;
		_targetPosition = target;
	}
	_speedMultiplier = speedMultiplier;
	_accelerationMultiplier = accelerationMultiplier;
	_steeringSpeed = steeringSpeed;
	_maximumAngle = maximumAngle;
	_minimumDistance = minimumDistance;
	_decelerate = decelerate; 
	_decelerationRadius = decelerationRadius; 
	_stopOnEnd = stopOnEnd;
	
	_decelerationMultiplier = 1;
	
	dv = noone;
	cv = noone;
	pos = noone;
	
	GetSteeringVector = function(_speed, _currentPosition, _currentVelocity) {
		var steeringMultiplier = _steeringSpeed;
		var _desiredVelocity = _targetPosition.Subtract(_currentPosition).Normalized().Multiply(_speed * _speedMultiplier);

        //Calculates angle between velocity calculated above and current, actual velocity.
        //If this value is greater than the desired maximum angle, velocity is unaltered.
        var _angle = _currentVelocity.Normalized().Angle(_desiredVelocity.Normalized());

		dv = _currentPosition.Add(_desiredVelocity.Normalized().Multiply(100));
		cv = _currentPosition.Add(_currentVelocity.Normalized().Multiply(100));
		pos = _currentPosition;

        //show_debug_message(_angle);
		if(_currentVelocity.Length() != 0 && _angle >= _maximumAngle)
            return _currentVelocity.Normalized();

        //Calculates the hypotenuse vector between the current and desired velocities, multiplied by the turning speed.
        //Returns this normalized value.
        _steeringVector = _desiredVelocity.Subtract(_currentVelocity).Multiply(steeringMultiplier);
		
		 if(_decelerate) {
            _decelerationMultiplier = 1;
            var distance = _currentPosition.Distance(_targetPosition);
            if(distance <= _decelerationRadius) {
                _decelerationMultiplier = clamp(distance, 0, distance) / _decelerationRadius;
                _steeringVector = _steeringVector.Multiply(_decelerationMultiplier);
            }
            //show_debug_message(string(distance) + " vector: " + _targetPosition.String() + " Multiplier: " + string(decelerationMultiplier));
        }

		show_debug_message(_decelerationMultiplier)

        return _currentVelocity.Add(_steeringVector).Normalized();
	}
	
	CheckCondition = function(_target){
		return _target._position().Distance(_targetPosition) <= _minimumDistance;
	}
	Update = function(_target) 
    {
		if(_targetObject != noone)
			_targetPosition = _targetObject._position();

		_desiredDirection = GetSteeringVector(_target._currentSpeed, _target._position(), _target._currentVelocity());
		_target.Move(_desiredDirection, _target._currentSpeed * _speedMultiplier * _decelerationMultiplier, _target._currentAcceleration * _accelerationMultiplier);
	}
	OnFinish = function(_target) {
		if(_stopOnEnd)
			_target.Stop();
	}
	Draw = function() {
		draw_line_width_color(pos._x, pos._y, cv._x, cv._y, 2, c_red, c_red);
		draw_line_width_color(pos._x, pos._y, dv._x, dv._y, 2, c_green, c_green);
	}
}