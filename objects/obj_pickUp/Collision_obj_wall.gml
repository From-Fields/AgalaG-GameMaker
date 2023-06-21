/// @description Insert description here
// You can write your code in this editor


normal = new Vector2(phy_col_normal_x, phy_col_normal_y);
velocity = new Vector2(phy_linear_velocity_x, phy_linear_velocity_y);

targetVelocity = velocity.Reflect(normal.Normalized);

phy_linear_velocity_x = targetVelocity._x;
phy_linear_velocity_y = targetVelocity._y;