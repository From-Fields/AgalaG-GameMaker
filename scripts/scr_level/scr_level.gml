// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_level(waves) constructor{
	_waveQueue = waves;

    HasNextWave = function() { 
		return ds_queue_size(_waveQueue) > 0;
	}

    WaveList = function() {
		return (_waveQueue);
	}

    GetNextWave = function()
    {
        if(HasNextWave())
            return ds_queue_dequeue(_waveQueue);

        return undefined;
    }
}