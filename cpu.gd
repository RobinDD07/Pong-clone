extends StaticBody2D

var ball_posn
var dist: int
var move_by: int
var window_height
var pad_height


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_height = get_viewport_rect().size.y
	pad_height = $ColorRect.size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ball_posn = $"../ball".position
	dist = position.y - ball_posn.y
	
	#if abs(dist) > get_parent().SPEED:
	move_by = get_parent().SPEED * sign(dist) #or we can use sign(dist) which wont give div b
	position.y -= move_by
	#else:
		#move_by = dist
	position.y = clamp(position.y, pad_height/2, window_height - pad_height/2)
	
	
