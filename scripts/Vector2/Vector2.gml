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
	
	Multiply = function(_num) {
		return new Vector2(_x * _num, _y * _num)
	}
}