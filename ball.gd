extends CharacterBody2D

@onready var normal = $"../menu/normal"
var curr_normal : bool = false
@onready var hard = $"../menu/hard"
var curr_hard:bool = false



var window_size : Vector2
const start_speed = 500
const acceleration_normal = 90
const acceleration_hard = 1.1
var speed : int
var dirn: Vector2
var game_running:bool = false

func _ready() -> void:
	window_size = get_viewport_rect().size
	normal.pressed.connect(_on_normal_pressed)
	hard.pressed.connect(_on_hard_pressed)
	

func _process(delta: float) -> void:
	if game_running:
		if Input.is_action_just_pressed("pause"):
			get_tree().paused = !get_tree().paused
			$"../pause".visible = get_tree().paused

func new_ball():
	position.x = window_size.x/2
	position.y = window_size.y/2
	if game_running:
		speed = start_speed
		dirn = random_direction()
	else:
		speed = 0
		dirn = Vector2.ZERO

func random_direction():
	var new_dirn : Vector2
	new_dirn.x = [-1,1].pick_random()
	new_dirn.y = randf_range(-1,1)
	return new_dirn.normalized()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(dirn * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if curr_normal:
			if collider == $"../Player" or collider == $"../CPU":
				speed += acceleration_hard
				dirn = new_dirn(collider)
				
			#dirn = dirn.bounce(collision.get_normal())
			else :
				#dirn = new_dirn(collider)
				dirn = dirn.bounce(collision.get_normal())
		elif curr_hard:
			if collider == $"../Player" or collider == $"../CPU":
				speed *= acceleration_hard
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


func _on_normal_pressed():
	game_running = !game_running
	new_ball()
	curr_normal = true
	curr_hard = false
	$"../menu".hide()
	

func _on_hard_pressed():
	game_running = !game_running
	new_ball()
	curr_hard = true
	curr_normal = false
	$"../menu".hide()
	
	


func _on_restart_pressed() -> void:
	new_game()
	
	
func new_game():
	$"../menu".show()
	$"..".scores[0]=0
	$"../hud/playerscore".text = str( $"..".scores[0])
	$"..".scores[1]=0
	$"../hud/computerscore".text = str( $"..".scores[1])
	$"../pause".visible = !get_tree().paused
	get_tree().paused = false
	game_running = false
	new_ball()
