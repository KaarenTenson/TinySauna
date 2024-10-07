extends Camera2D

var timer = Timer.new()
# essa zoom: x = 
# teine zoom: x =
# stseeni positsioon: x = 576, y = 324

func _ready() -> void:
	timer.wait_time = 5.6
	timer.one_shot = true
	add_child(timer)
	timer.start()
	cutscene(timer)
	pass # Replace with function body.

func cutscene(timer):
	while timer.wait_time != 5.6:
		zoom -= Vector2(0.002, 0.002)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
