// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Vector2(_initX = 0, _initY = 0) constructor{
	_x = _initX;
	_y = _initY;
	
	Length = function() {
		return sqrt(power(_x, 2) + power(_y, 2));
	}
	
	Normalized = function() {
		var _length = Length();
		
		if(_length == 0)
			return self;
		
		var _nX = _x / _length;
		var _nY = _y / _length;
		
		return new Vector2(_nX, _nY);
	}
	Normalize = function() {
		var _length = Length();
		
		if(_length != 0) {
			var _nX = _x / _length;
			var _nY = _y / _length;
		
			_x = _nX;
			_y = _nY;
		}
		
		return self;
	}
	Multiply = function(_num) {
		return new Vector2(_x * _num, _y * _num)
	}
	Subtract = function(_other) {
		return new Vector2(_x - _other._x, _y - _other._y);	
	}
	Add = function(_other) {
		return new Vector2(_x + _other._x, _y + _other._y);	
	}
	Angle = function(_other) {
		var nV1 = Normalized()
		var nV2 = _other.Normalized();
		var v1 = point_direction(0, 0, nV1._x, nV1._y);
		var v2 = point_direction(0, 0, nV2._x, nV2._y);
		return abs(angle_difference(v1, v2));
	}
	Distance = function(_other) {
		return sqrt(power(_x - _other._x, 2) + power(_y - _other._y, 2));	
	}
	String = function() {
		return ("X: " + string(_x) + " Y: " + string(_y))
	}
	Rotate = function(_angle) {
		var _cos = cos(_angle);
		var _sin = sin(_angle);
		
		var x_ = _x * _cos - _y * _sin;
		var y_ = _x * _sin + _y * _cos;
		
		return new Vector2(x_, y_);
	}
}
