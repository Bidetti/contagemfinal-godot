extends Area2D

@export var speed: float = 800
@export var damage: int = 10
var direction = Vector2.ZERO

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
	queue_free()
