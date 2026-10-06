extends StaticBody2D
var window_height
var pad_height

func _ready() -> void:
	window_height = get_viewport_rect().size.y
	pad_height = $ColorRect.size.y

func _process(delta: float) -> void:
	var direction = Input.get_axis("up","down")
	position.y+= get_parent().SPEED*direction*delta
	
	position.y = clamp(position.y, pad_height/2, window_height - pad_height/2)
	

#const speed: int = 10
#
#
#func _physics_process(delta: float) -> void:
	#var direction = Input.get_axis("up","down")
	#position.y+=speed*direction
