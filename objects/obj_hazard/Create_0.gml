/// @description Insert description here
// You can write your code in this editor

event_inherited();

_currentHealth = 1;
_damage = 1;

_willRemove = false;
_isWithinBounds = false;
_canBounce = false;
_currentBounces = 0;
_maxBounces = 0;

_rotate = false;
_rotationSpeed = undefined;

// References
_powerUp = undefined;

onRelease = new EventListener();

x = 0;
y = 0;

visible = false;
instance_deactivate_object(id);
_boundFixture = undefined;
_deathSound = sfx_death_enemy;
_bounceSound = sfx_bounce;

Initialize = function(
    position, direction_, 
	maxBounces = 0,
	health_ = 1, damage = 1,
	speed_ = 2000, rotate = true, rotationSpeed = 100,
	scale = new Vector2(1, 1),
	sprite_ = spr_hazard_a
) {
	// Rotation
    _rotate = rotate;
    _rotationSpeed = rotationSpeed;
	_currentAngle = 0;

	// Attributes
	_currentHealth = health_;
	_damage = damage;
	
	// Bounce
	_bounceCooldown = true;
	_willRemove = false;
	_isWithinBounds = false;
	_currentBounces = 0;
	_maxBounces = maxBounces;
	_canBounce = _maxBounces > 0;
	
	// Postition
    sprite_index = sprite_;
	phy_active = true;
    x = position._x;
    y = position._y;
    phy_position_x = position._x;
    phy_position_y = position._y;
	
	// Scale
	image_xscale = scale._x;
    image_yscale = scale._y;
	
	// Active
	phy_fixed_rotation = true;
	visible = true;
	instance_activate_object(id);
    
	// Movement
	_velocity = undefined;
	_direction = direction_;
	_speed = speed_;
    ApplyPhisicsMovement(direction_, speed_);
	SetCollisionGroup(-1);
	
	_timer = undefined;
	_pause = instance_find(obj_pause_controller, 0);
	_pause.onPause.AddListener(OnPause);
}

SetCollisionGroup = function(group) {
	if(_boundFixture != undefined) 
		physics_remove_fixture(id, _boundFixture);
	
	var _fixture = physics_fixture_create();
	physics_fixture_set_box_shape(_fixture, 48, 48);
	physics_fixture_set_collision_group(_fixture, group);
	physics_fixture_set_density(_fixture, 1);
	physics_fixture_set_restitution(_fixture, 0);
	physics_fixture_set_linear_damping(_fixture, 0);
	physics_fixture_set_angular_damping(_fixture, 0);
	_boundFixture = physics_fixture_bind(_fixture, self);
}

TakeDamage = function(_amount) {	
	_currentHealth = clamp(_currentHealth - _damage, 0, _currentHealth);
	
	if(_currentHealth == 0) {
		Die();
	}
}

Die = function() {
	audio_play_sound_on(_audioEmitter, _deathSound, false, 3);
	ReserveToPool();
}

ReserveToPool = function() {
	if(phy_active == false)
        return;
	
	phy_active = false;
	visible = false;
	x = 0;
	y = 0;
	phy_position_x = 0;
	phy_position_y = 0;
	instance_deactivate_object(id);

	Pool().Release(id);
}

Pool  = function() { return new HazardPool().Instance(); }
ResetCooldown = function() { _bounceCooldown = true; }

OnPause = function(paused) {
	if(_timer == undefined)
		return;
		
	if(paused) {
		time_source_pause(_timer_a);
		time_source_pause(_timer_b);
	}
	else {
		time_source_resume(_timer_a);
		time_source_resume(_timer_b);
	}
}