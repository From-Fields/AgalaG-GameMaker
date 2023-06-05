/// @description Insert description here
// You can write your code in this editor

event_inherited()

_fromChild = _position.Subtract(_parent._position).Normalized();
_toChild = _parent._position.Subtract(_position).Normalized();
_tangent = _fromChild.Rotate(degtorad(90)).Normalized();

var distance = _position.Distance(_parent._position);
var offsetMultiplier = _velocityMultiplier * (_orbitMultiplier * distance/_positionOffset);
var acceleration = _parent._currentAcceleration;
var _desiredOrbit = _velocityMultiplier * _tangent * _orbitingVelocity * _orbitMultiplier * 2 * pi * _positionOffset / distance;

_desiredOrbit += (_toChild * _orbitingVelocity * offsetMultiplier);
            
_desiredOrbit *= delta_time / 1000000;;

ApplyPhisicsMovement(_desiredOrbit.Normalized(), _desiredOrbit.Length(), _currentAcceleration);

if(_desiredVelocity != undefined) {
    if(_desiredVelocity.Length() == 0)
        _desiredVelocity = undefined;
    else {
		ApplyPhisicsMovement(_desiredVelocity.Normalized(), _desiredVelocity.Length(), acceleration);
        _desiredVelocity = new Vector2(0, 0);
    }
}