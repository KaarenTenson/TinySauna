extends Control


# Called when the node enters the scene tree for the first time.
var timervahe= 7
var timer=7
func _ready() -> void:
	$AnimatedSprite2D.play("wizard_idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer-=delta
	if(timer<=0):
		timer=timervahe
		$AnimatedSprite2D.animation_finished.connect(vaheta)
		$AnimatedSprite2D.play("wizard_dance")
		
func vaheta(nimi):
	if(nimi=="wizard_dance"):
		$AnimatedSprite2D.play("wizard_idle")
	
