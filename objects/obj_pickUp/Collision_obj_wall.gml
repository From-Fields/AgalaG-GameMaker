/// @description Insert description here
// You can write your code in this editor

if(_velocity == undefined) {
	_velocity = new Vector2(_direction.Multiply(_speed * delta_time / 1000000));
}

normal = new Vector2(phy_col_normal_x, phy_col_normal_y);

targetVelocity = _velocity.Reflect(normal.Normalized());

phy_linear_velocity_x = 0;
phy_linear_velocity_y = 0;

ApplyPhisicsMovement(targetVelocity, _speed)