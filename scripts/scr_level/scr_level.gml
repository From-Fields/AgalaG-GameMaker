// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Level(waves) constructor{	
	BuildCache = function(waves_) {
		var waveCache = ds_list_create();
		var waveCount = ds_list_size(waves_);
		
		for(var i = 0; i < waveCount; i++) {
			var currentWave = ds_list_find_value(waves_, i);			
			ds_list_add(waveCache, currentWave);	
		}
		
		return waveCache;
	}
	BuildQueue = function(cache_) {
		var waveQueue = ds_queue_create();
		var waveCount = ds_list_size(cache_);
		
		for(var i = 0; i < waveCount; i++) {
			var currentWave = ds_list_find_value(cache_, i);			
			ds_queue_enqueue(waveQueue, currentWave);	
		}
		
		return waveQueue;
	}

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
	
	_waveCache = BuildCache(waves);
	_waveQueue = BuildQueue(_waveCache);
}

function EndlessLevel(waves): Level(waves) constructor{
	_previousWave = undefined;
	_currentWave = undefined;
	
	HasNextWave = function() { return true; }
	
	GetNextWave = function() {
        _previousWave = _currentWave;

        if(ds_queue_size(_waveQueue) == 0) {
            do {
                ShuffleWaves();
                _currentWave = ds_queue_dequeue(_waveQueue);
				
				if(ds_list_size(_waveCache) == 1)
					break;				
            } until(_currentWave != _previousWave);
        }
        else {
            _currentWave = ds_queue_dequeue(_waveQueue);
        }

        return _currentWave;
    }
	ShuffleWaves = function(cache_) {
		var shuffledCache = ds_list_create();
		ds_list_copy(shuffledCache, cache_);
		ds_list_shuffle(shuffledCache);
		
		return BuildQueue(shuffledCache);
	}
	
	_waveQueue = ShuffleWaves(_waveCache);
}