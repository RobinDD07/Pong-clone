extends Sprite2D

var scores := [0,0]
const SPEED: int = 5


func _on_ball_timer_timeout() -> void:
	$ball.new_ball()

#cpu ka score
func _on_left_body_entered(body: Node2D) -> void:
	scores[1] += 1
	$hud/computerscore.text = str(scores[1])
	$ballTimer.start()

#plater ka score
func _on_right_body_entered(body: Node2D) -> void:
	scores[0] += 1
	$hud/playerscore.text = str(scores[0])
	$ballTimer.start()
