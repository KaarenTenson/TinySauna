extends Camera2D

var tingimus = false
var scene = 1
var zoom_speed = 20
var zoom_strength = 0.1
var base_zoom = Vector2(1, 1)
var zoom_time = 0.0 
var cutscene_timer = 0.0
var cutscene_kestvus = 5.6
# essa zoom: x = 882, y = 274
# teine zoom: x = 261, y = 384
# stseeni positsioon: x = 576, y = 324

func _ready() -> void:
	position = Vector2(882, 274)
	zoom = Vector2(2.5, 2.5)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cutscene_zoom()
	if (Globals.get_combo() > 5):
		zoom_time += delta * zoom_speed
		var zoom_factor = sin(zoom_time) * zoom_strength
		var new_zoom = base_zoom + Vector2(zoom_factor, zoom_factor)
		new_zoom.x = clamp(new_zoom.x, 1, 1.1)
		new_zoom.y = clamp(new_zoom.y, 1, 1.1)
		zoom = new_zoom
	else:
		cutscene_timer += delta
		if cutscene_timer >= cutscene_kestvus:
			zoom.x = lerp(zoom.x, base_zoom.x, 0.1)
			zoom.y = lerp(zoom.y, base_zoom.y, 0.1)

func cutscene_zoom():
	if scene == 1:
		zoom -= Vector2(0.002, 0.002)
		if zoom <= Vector2(2.15, 2.15):
			scene += 1
			zoom = Vector2(3.5, 3.5)
			position = Vector2(261, 384)
	elif scene == 2:
		zoom -= Vector2(0.005, 0.005)
		if zoom <= Vector2(2.827969, 2.827969):
			scene += 1
			position = Vector2(576, 324)
			zoom = Vector2(3.5, 3.5)
	elif scene == 3:
		zoom -= Vector2(0.02, 0.02)
		if zoom <= Vector2(1.01, 1.01):
			scene += 1
	else:
		return
			
	
