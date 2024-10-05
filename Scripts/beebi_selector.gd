extends VBoxContainer
@onready var beebi: TextureRect = $"../Beebi"
@onready var vasak: Button = $HBoxContainer/vasak
@onready var parem: Button = $HBoxContainer/parem



var valikud=[{"jijitsuBeebi":"res://Assets/Beebid/es.png"},{"KungFuBeebi":"res://Assets/Beebid/ko.png"},{"TaekWonDooBeebi":"res://Assets/Beebid/ne.png"},
{"KarateBeebi":"res://Assets/Beebid/te.png"}]

var indeks=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2.play()
	Globals.ChosenBeebi=valikud[1].keys()[0]
	beebi.texture= load(valikud[1].values()[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_vasak_pressed() -> void:
	$AudioStreamPlayer2.play()
	if(indeks>0):
		indeks-=1
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
		beebi.texture= load(valikud[indeks].values()[0])
	else:
		indeks=valikud.size()-1
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
		beebi.texture= load(valikud[indeks].values()[0])
	

func _on_parem_pressed() -> void:
	$AudioStreamPlayer2.play()
	if(indeks<valikud.size()-1):
		indeks+=1
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
		beebi.texture= load(valikud[indeks].values()[0])
	else:
		indeks=0
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
		beebi.texture= load(valikud[indeks].values()[0])
	


func _on_start_pressed() -> void:
	Globals.Score=0
	Globals.Score_Multiplier=1
	get_tree().change_scene_to_file("res://main.tscn")
