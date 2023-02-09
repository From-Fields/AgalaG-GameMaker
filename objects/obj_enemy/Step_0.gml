/// @description Insert description here
// You can write your code in this editor

if(_currentAction != undefined) {
	if(_currentAction.CheckCondition(self))
		ExecuteNextAction();
		
	if(_currentAction != undefined) {
		_currentAction.Update(self);
	}
}