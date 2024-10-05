extends TextureRect
var timer=1
@onready var anim = $key_press

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
	anim.animation_finished.connect(havita)
	anim.play("key_press")

func havita(a):
	queue_free()
