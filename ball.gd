extends CharacterBody2D

var window_size : Vector2
const start_speed = 2
const acceleration = 1.5
var speed : int
var dirn: Vector2

func _new_ball():
	position.x = window_size.x/2
	position.y = randi_range(200, window_size.y)
	speed = start_speed
	dirn = random_direction()

func random_direction():
	var new_dirn : Vector2
	#
	new_dirn.x = [-1,1].pick_random()
	new_dirn.y = randf_range(-1,1)
	return new_dirn.normalized()

func _physics_process(delta: float) -> void:
	move_and_collide(dirn * speed * delta)
