extends Node
var Strength=4
var Speed=1
var Potions=3
var Skill_Points=5
var ChosenBeebi
var Score=0
var Score_Multiplier=1

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
