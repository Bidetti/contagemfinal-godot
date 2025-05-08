extends CharacterBody2D
class_name Character


enum State{IDLE}


signal teleported

@export_category("physics")
@export var speed = 100.0
@export var acceleration = 1000.0
@export var deceleration = 800.0

@export var actor_scene:PackedScene:
	set(v):
		actor_scene = v
		if !is_inside_tree():
			await ready
		if actor:
			actor.queue_free()
		actor = actor_scene.instantiate()

@export var team:ResourceDamageTeam:
	set(v):
		team = v


var actor:ActorSprite
var move_vector := Vector2.ZERO:
	set(v):
		move_vector = v
		if move_vector.length():
			sprite.direction = move_vector.normalized()
var state:State
var just_teleport := false

@onready var sprite: SpriteCharacter = $Sprite


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	match state:
		State.IDLE:
			if move_vector.length():
				sprite.anim = SpriteCharacter.Anim.MOVING
				velocity = velocity.move_toward(move_vector*speed,acceleration*delta)
			else:
				sprite.anim = SpriteCharacter.Anim.IDLE
				velocity = velocity.move_toward(Vector2.ZERO,deceleration*delta)
	move_and_slide()
