extends Node
var Strength=1
var Speed=1
var Potions=1
var Skill_Points=5
var ChosenBeebi
var Score=0
var Score_Multiplier=1
var Enemy_Hp=100
signal On_Hp0
signal On_HpChanged

var hp=100:
	set(value):
		if(value<=0):
			On_HpChanged.emit(value)
			On_Hp0.emit()
		else:
			On_HpChanged.emit(value)
			hp=value
		

func Get_Strength() -> int:
	return Strength
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func Add_Score():
	Score+=int(10*Score_Multiplier)
func Dec_Multiplier():
	Score_Multiplier*=0.7
func Inc_Multiplier():
	Score_Multiplier*=1.1
func Get_Damage() -> float:
	return Score_Multiplier*Strength
func Recive_Damage():
	hp-=10
func Get_Key_Delete() -> float:
	return sqrt(Speed)*1/(sqrt(Score_Multiplier))
func Get_Regen() -> float:
	return 0.01*Potions
	
