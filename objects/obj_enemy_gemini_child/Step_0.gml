/// @description Insert description here
// You can write your code in this editor

event_inherited()

_fromChild = _position().Subtract(_parent._position()).Normalized();
_toChild = _parent._position().Subtract(_position()).Normalized();
_tangent = _fromChild.Rotate(degtorad(90)).Normalized();

if(_tangent.Length() == 0)
	return;

var distance = _position().Distance(_parent._position());
var offsetMultiplier = _velocityMultiplier * (_orbitMultiplier * distance/_positionOffset);
var _desiredOrbit = _tangent.Multiply(_velocityMultiplier * _orbitingVelocity * _orbitMultiplier * 2 * pi * _positionOffset / distance);

_desiredOrbit = _desiredOrbit.Add(_toChild.Multiply(_orbitingVelocity * offsetMultiplier));
            
_desiredOrbit = _desiredOrbit.Multiply(delta_time / 1000000);

if(_desiredVelocity != undefined) {
    if(_desiredVelocity.Length() == 0)
        _desiredVelocity = undefined;
    else {
		_desiredOrbit = _desiredOrbit.Add(_desiredVelocity);
        _desiredVelocity = new Vector2(0, 0);
    }
}


ApplyPhisicsMovement(_desiredOrbit.Normalized(), _desiredOrbit.Length(), _currentAcceleration);