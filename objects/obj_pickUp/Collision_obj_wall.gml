/// @description Insert description here
// You can write your code in this editor

show_debug_message("Collided!")

normal = new Vector2(phy_col_normal_x, phy_col_normal_y);
show_debug_message("Normal: " + normal.String());

targetVelocity = velocity.Reflect(normal.Normalized());

phy_linear_velocity_x = 0;
phy_linear_velocity_y = 0;

ApplyPhisicsMovement(targetVelocity, _speed)