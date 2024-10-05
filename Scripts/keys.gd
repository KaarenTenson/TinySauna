extends TextureRect
var timer=1
@onready var anim = $key_press
signal Removed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(timer<0):
		Globals.Dec_Multiplier()
		Globals.Recive_Damage()
		Globals.reset_combo()
		anim.play("fail")
		anim.animation_finished.connect(havita)
		timer=10
		
	else:
		timer-=delta

func Destroy_Self():
	timer=10
	anim.animation_finished.connect(havita)
	#explosion.position=self.positionease the number of particles
	anim.play("key_press")

func havita(a):
	queue_free()
	if(a!="fail"):
		Removed.emit(self.position)
