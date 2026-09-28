extends StaticBody2D
const speed: float = 10


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("up","down")
	position.y+=speed*direction
