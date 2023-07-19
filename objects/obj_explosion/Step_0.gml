expand();

var enemy = instance_place(x, y, obj_enemy);
if (enemy != noone)
{
	enemy.TakeDamage(damage);
}