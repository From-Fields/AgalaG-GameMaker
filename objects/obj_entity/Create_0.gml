/// @Interface

// Attributes
_health = 0;
_maxHealth = 1;
_position = function() { return new Vector2(phy_position_x, phy_position_y); }
_currentVelocity = function() { return new Vector2(phy_linear_velocity_x, phy_linear_velocity_y); }

// Methods
TakeDamage = function(_damage){}
Move = function(_direction, _speed, _acceleration){}
Shoot = function(){}
Stop = function() {}
Die = function(){}