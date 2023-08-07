/// @description Insert description here
// You can write your code in this editor

_score = 0;

_player = undefined;
_level = undefined;

_currentWave = undefined;

onNoWave = undefined;
onGameOver = undefined;

_restarting = false;

UpdateScore = function(points) {
	_score += points;
}

Create = function(level, player) {
	_player = player;
	_level = level;
}

Initialize = function() {
	if (instance_exists(_player))
		_player.onDeath.AddListener(GameOver);
	if (!_restarting)
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
    _currentWave.Initialize();
    _currentWave._onWaveDone.AddListener(CallNextWave);
}

EndLevel = function() {
	if(onNoWave != undefined)
		onNoWave.Invoke();
    ClearEvents();
} 
GameOver = function() {
	if(onGameOver != undefined)
		onGameOver.Invoke();
    ClearEvents();
	obj_gameoverui_controller.show = true;
} 
ClearEvents = function() {
    onNoWave = undefined;
    onGameOver = undefined;
    _player.onDeath.RemoveListener(GameOver);
}


_level = global.level();
_player = instance_find(obj_player, 0);
Initialize();