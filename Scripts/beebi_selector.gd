extends VBoxContainer
@onready var beebi: TextureRect = $"../Beebi"
@onready var vasak: Button = $HBoxContainer/vasak
@onready var parem: Button = $HBoxContainer/parem

var valikud=[{"jijitsuBeebi":"res://Assets/Beebid/es.png"},{"KungFuBeebi":"res://Assets/Beebid/ko.png"},{"TaekWonDooBeebi":"res://Assets/Beebid/ne.png"},
{"KarateBeebi":"res://Assets/Beebid/te.png"}]


var indeks=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.ChosenBeebi=valikud[1].keys()[0]
	beebi.texture= load(valikud[1].values()[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_vasak_pressed() -> void:
	if(indeks>0):
		indeks-=1
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
		beebi.texture= load(valikud[indeks].values()[0])

func _on_parem_pressed() -> void:
	if(indeks<valikud.size()-1):
		indeks+=1
		Globals.ChosenBeebi=valikud[indeks].keys()[0]
		beebi.texture= load(valikud[indeks].values()[0])
