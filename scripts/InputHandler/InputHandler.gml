// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InputHandler() constructor{
	//global._inputHandler = noone;
	
	//static instance = function() {
	//	if(global._inputHandler == noone) {
	//		global._inputHandler = new InputHandler();
	//	}
		
	//	return global._inputHandler;
	//}
	
	Left = function() {
		return keyboard_check(ord("A"));
	}
	Right = function() {
		return keyboard_check(ord("D"));
	}
	Up = function() {
		return keyboard_check(ord("W"));
	}
	Down = function() {
		return keyboard_check(ord("S"));
	}
	
	HasMovement = function() {
		return GetMovement().Length() > 0;
	}
	GetMovement = function() {
		var _horizontalInput = Right() - Left();
		var _verticalInput = Down() - Up();
		
		return new Vector2(_horizontalInput, _verticalInput);
	}
	
	GetPause = function() {
		return keyboard_check(vk_escape);
	}
	
	GetShoot = function() {
		return keyboard_check_pressed(ord("J"));
	}
}