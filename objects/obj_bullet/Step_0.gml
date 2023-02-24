var collided = instance_place(x, y, obj_entity);

Move(_direction, _speed);

if (collided != noone) {
	if (!_isPlayer && collided.object_index == obj_player) {
		show_debug_message("it's the player!");
		collided.TakeDamage(_damage);
		DestroySelf();
	}
	else if (_isPlayer && object_get_parent(collided.object_index) == obj_enemy) {
		show_debug_message("it's the enemy!");
		collided.TakeDamage(_damage);
		DestroySelf();
	}
}