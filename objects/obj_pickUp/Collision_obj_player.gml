/// @description Insert description here
// You can write your code in this editor




other.AddPowerUp(_powerUp);

phy_active = false;
visible = false;
x = 0;
y = 0;
phy_position_x = 0;
phy_position_y = 0;
instance_deactivate_object(id);

Pool().Release(id);
