extends CharacterBody2D

var window_size : Vector2
const start_speed = 500
const acceleration = 20
var speed : int
var dirn: Vector2

func _ready() -> void:
	window_size = get_viewport_rect().size

func new_ball():
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
	var collision = move_and_collide(dirn * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		
		if collider == $"../Player" or collider == $"../CPU":
			speed += acceleration
			dirn = new_dirn(collider)
			#dirn = dirn.bounce(collision.get_normal())
		else :
			#dirn = new_dirn(collider)
			dirn = dirn.bounce(collision.get_normal())
			
func new_dirn(collider):
	var ball_y = position.y
	var paddle_y = collider.position.y
	var dist = ball_y - paddle_y
	var new_dirn := Vector2()
	
	if dirn.x > 0:
		new_dirn.x =-1
	else:
		new_dirn.x = 1
		
	new_dirn.y = (dist / (collider.pad_height/2))
	return new_dirn.normalized()
