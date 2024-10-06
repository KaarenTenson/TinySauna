extends Node
var Strength=1
var Speed=1
var Potions=1
var Skill_Points=5

signal On_Babychanged
var ChosenBeebi="TaekWonDooBeebi":
	set(value):
		On_Babychanged.emit(value)
		ChosenBeebi=value
var Score=0
var Score_Multiplier=1
var Enemy_Hp=100
var combo = 0
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
	Score_Multiplier = 1
	combo = 0
func Inc_Multiplier():
	combo += 1
	if (Score_Multiplier < 3):
		Score_Multiplier += 0.1
func Get_Damage() -> float:
	return Score_Multiplier*Strength
func Recive_Damage():
	hp-=10
func Get_Key_Delete() -> float:
	return sqrt(Speed)*1/(sqrt(Score_Multiplier))
func Get_Regen() -> float:
	return Potions
func Get_MoveSpeed() -> float:
	return Globals.Speed*(Globals.Score_Multiplier+combo)
func get_combo() -> int:
	return combo
func reset_Score():
	Score=0
	Score_Multiplier=0
	combo=0
	hp=100
func Get_Skill_Points():
	if(Score<1000):
		Skill_Points+=2
	elif(Score<10000):
		Skill_Points+=5
	elif(Score<100000):
		Skill_Points+=10
	else:
		Skill_Points+=12
func reset_skills():
	Speed=1
	Strength=1
	Potions=1
	Skill_Points=1

	
func reset_combo():
	combo = 0
