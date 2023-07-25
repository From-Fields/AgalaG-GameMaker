/// @description Insert description here
// You can write your code in this editor

if(phy_active == false || !_bounceCooldown)
	return;

if(_velocity == undefined) {
	_velocity = new Vector2(_direction.Multiply(_speed * delta_time / 1000000));
}

	
normal = new Vector2(phy_col_normal_x, phy_col_normal_y);
targetVelocity = _velocity.Reflect(normal.Normalized());

phy_linear_velocity_x = 0;
phy_linear_velocity_y = 0;

ApplyPhisicsMovement(targetVelocity, _speed)
_bounceCooldown = false;
audio_play_sound_on(_audioEmitter, _bounceSound, false, 3);

_timer = time_source_create(time_source_game, 10, time_source_units_frames, ResetCooldown);
time_source_start(_timer);