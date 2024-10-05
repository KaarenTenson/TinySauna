extends TextureRect
var timer=1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(timer<0):
		Globals.Dec_Multiplier()
		queue_free()
	else:
		timer-=delta
func Destroy_Self():
	queue_free()
