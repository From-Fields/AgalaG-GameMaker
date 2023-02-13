/// @Interface

// Attributes
_health = 0;
_position = function() { return new Vector2(x, y); }
_currentVelocity = function() { return new Vector2(phy_linear_velocity_x, phy_linear_velocity_y); }

// Methods
TakeDamage = function(_damage){}
Move = function(_direction, _speed, _acceleration){}
Shoot = function(){}
Die = function(){}