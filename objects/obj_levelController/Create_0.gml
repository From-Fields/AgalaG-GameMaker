/// @description Insert description here
// You can write your code in this editor

_player = undefined;
_level = undefined;

_currentWave = undefined;

Create = function(level, player) {
	_player = player;
	_level = level;
}

Initialize = function() {
	_player.onDeath.AddListener(GameOver);
	CallNextWave();
}

CallNextWave = function() {
	if(_currentWave != undefined) {
        _currentWave._onWaveDone.RemoveListener(CallNextWave);
        _currentWave = undefined;
	}
	
	if(!_level.HasNextWave()) {
        EndLevel();
        return;
    }
	
	_currentWave = _level.GetNextWave();
    _currentWave._onWaveDone.AddListener(CallNextWave);
    _currentWave.Initialize();
}

EndLevel = function() {
    onNoWave.Invoke();
    ClearEvents();
} 
GameOver = function() {
    onGameOver.Invoke();
    ClearEvents();
} 
ClearEvents = function() {
    onNoWave = undefined;
    onGameOver = undefined;
    _player.onDeath.RemoveListener(GameOver);
}


_level = global.level();
_player = instance_find(obj_player, 0);
Initialize();