extends VBoxContainer
@onready var skillpoints: Label = $skillpoints
@onready var potions: TextureProgressBar = $HBoxContainer3/Potions
@onready var speed: TextureProgressBar = $HBoxContainer2/Speed
@onready var strength: TextureProgressBar = $HBoxContainer/Strength




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()
	skillpoints.text="points:"+str(Globals.Skill_Points)
	speed.value=Globals.Speed*10
	potions.value=Globals.Potions*10
	strength.value=Globals.Strength*10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_strength_b_pressed() -> void:
	if(Globals.Skill_Points>0&&Globals.Strength<10):
		Globals.Skill_Points-=1
		Globals.Strength+=1
		strength.value=strength.value+10
	skillpoints.text="points:"+str(Globals.Skill_Points)
	$AudioStreamPlayer.play()


func _on_speed_b_pressed() -> void:
	if(Globals.Skill_Points>0&&Globals.Speed<10):
		Globals.Skill_Points-=1
		Globals.Speed+=1
		speed.value=speed.value+10
	skillpoints.text="points:"+str(Globals.Skill_Points)
	$AudioStreamPlayer.play()


func _on_potions_b_pressed() -> void:
	if(Globals.Skill_Points>0&&Globals.Potions<10):
		Globals.Skill_Points-=1
		Globals.Potions+=1
		potions.value=potions.value+10
	skillpoints.text="points:"+str(Globals.Skill_Points)
	$AudioStreamPlayer.play()
	
	
	
