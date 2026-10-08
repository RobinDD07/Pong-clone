extends StaticBody2D
var window_height
var pad_height
var dist: float
var move_by: float
var ball_posn

var pvp:bool = false
var pve:bool = false

func _ready() -> void:
	window_height = get_viewport_rect().size.y
	pad_height = $ColorRect.size.y

func _process(delta: float) -> void:
	if  pvp:
		var direction = Input.get_axis("top","bot")
		position.y+= get_parent().SPEED*direction*delta
		
		position.y = clamp(position.y, pad_height/2, window_height - pad_height/2)
		
	else :
		ball_posn = $"../ball".position
		dist = position.y - ball_posn.y
		
		if abs(dist) > get_parent().SPEED:
			move_by = get_parent().SPEED * sign(dist) * delta #or we can use sign(dist) which wont give div b
			
		else:
			move_by = dist
		position.y -= move_by
		position.y = clamp(position.y, pad_height/2, window_height - pad_height/2)
		

func _on_pvp_pressed() :
	var pressed_colour = Color(0.394, 0.93, 0.777, 1.0)
	var other_colour = Color(1.0, 1.0, 1.0, 1.0)
	$"../menu/PVP".add_theme_color_override("font_color",pressed_colour)
	$"../menu/PVE".add_theme_color_override("font_color",other_colour)
	pvp = true
	pve = false


func _on_pve_pressed() :
	var pressed_colour = Color(0.394, 0.93, 0.777, 1.0)
	var other_colour = Color(1.0, 1.0, 1.0, 1.0)
	$"../menu/PVE".add_theme_color_override("font_color",pressed_colour)
	$"../menu/PVP".add_theme_color_override("font_color",other_colour)
	pve = true
	pvp = false
