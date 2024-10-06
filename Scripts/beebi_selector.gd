extends VBoxContainer
@onready var beebi: TextureRect = $"../Beebi"
@onready var vasak: Button = $HBoxContainer/vasak
@onready var parem: Button = $HBoxContainer/parem
@onready var tantsud = $AnimatedSprite2D

var valikud=[{"jijitsuBeebi":"res://Assets/Beebid/es.png"},{"KungFuBeebi":"res://Assets/Beebid/ko.png"},{"TaekWonDooBeebi":"res://Assets/Beebid/ne.png"},
{"KarateBeebi":"res://Assets/Beebid/te.png"}]


var indeks=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tantsud.play("taekwondo_dance")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_vasak_pressed() -> void:
	if(indeks>0):
		indeks-=1
		Globals.ChosenBeebi = valikud[indeks].keys()[0]
	else:
		indeks=valikud.size()-1
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
	
	print(Globals.ChosenBeebi)
	if (Globals.ChosenBeebi == "KarateBeebi"):
		tantsud.play("karate_dance")
	elif (Globals.ChosenBeebi == "TaekWonDooBeebi"):
		tantsud.play("taekwondo_dance")
	elif (Globals.ChosenBeebi == "KungFuBeebi"):
		tantsud.play("kungfu_dance")
	elif (Globals.ChosenBeebi == "jijitsuBeebi"):
		tantsud.play("jiujitsu_dance")
	$AudioStreamPlayer2.play()

func _on_parem_pressed() -> void:
	if(indeks<valikud.size()-1):
		indeks+=1
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
	else:
		indeks=0
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
		
	print(Globals.ChosenBeebi)
	if (Globals.ChosenBeebi == "KarateBeebi"):
		tantsud.play("karate_dance")
	elif (Globals.ChosenBeebi == "TaekWonDooBeebi"):
		tantsud.play("taekwondo_dance")
	elif (Globals.ChosenBeebi == "KungFuBeebi"):
		tantsud.play("kungfu_dance")
	elif (Globals.ChosenBeebi == "jijitsuBeebi"):
		tantsud.play("jiujitsu_dance")
	$AudioStreamPlayer2.play()


func _on_start_pressed() -> void:
	Globals.Score=0
	Globals.Score_Multiplier=1
	
	get_tree().change_scene_to_file("res://main.tscn")
