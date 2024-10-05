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
		Globals.Recive_Damage()
		anim.play("fail")
		anim.animation_finished.connect(havita)
		timer=10
		
	else:
		timer-=delta

func Destroy_Self():
	anim.play("key_press")
	anim.animation_finished.connect(havita)
	

func havita(a):
	queue_free()
