/// @description Insert description here
// You can write your code in this editor


if(phy_active == false || !_canBounce || !_bounceCooldown)
	return;
	

if(_velocity == undefined) {
	_velocity = new Vector2(_direction.Multiply(_speed * delta_time / 1000000));
}

normal = new Vector2(phy_col_normal_x, phy_col_normal_y);
targetVelocity = _velocity.Reflect(normal.Normalized());

phy_linear_velocity_x = 0;
phy_linear_velocity_y = 0;

ApplyPhisicsMovement(targetVelocity, _speed)

audio_play_sound_on(_audioEmitter, _bounceSound, false, 3);

_currentBounces++;
_bounceCooldown = false;
if(_currentBounces >= _maxBounces) 
	SetCollisionGroup(-1);

time_source_start(time_source_create(time_source_game, 10, time_source_units_frames, ResetCooldown));
