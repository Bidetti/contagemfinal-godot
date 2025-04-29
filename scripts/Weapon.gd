extends Node2D

@export var bullet_scene: PackedScene
@export var fire_rate: float = 0.5
var can_shoot = true

func shoot():
	if not can_shoot:
		return
	var bullet = bullet_scene.instantiate()
	bullet.global_position = $Marker2D.global_position
	bullet.direction = (get_global_mouse_position() - $Marker2D.global_position).normalized()
	get_tree().current_scene.get_node("Bullets").add_child(bullet)
	can_shoot = false
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true
