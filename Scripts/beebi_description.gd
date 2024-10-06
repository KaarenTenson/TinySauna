extends Control
var beebi_descriptions = {"jijitsuBeebi": "With powerful legs of steel, this warrior is known as an energetic fighter. Able to fracture the bones of his opponents with a graze, this combatant is banned in 18 countries and numerous states.", "KungFuBeebi": "A prodigy in his craft - this kung fu user is a ferocious combatant, who shows mercy to few. Featured in many high-quality films, he is an idol for many young martial artists.", "TaekWonDooBeebi": "Originating from the deep mountains in the Himalayas, he is considered a master at his martial art. Being a pacifist, he is known to be merciful. Many consider him an “Avatar of Peace”.", "KarateBeebi": "This fearsome combatant uses his strong durability to his advantage - because of this, he is feared across the globe. It is said he hailed from a dojo of snakes."}
var beebi_coolnames = {"jijitsuBeebi": "res://Assets/CoolNames/jiu-jitsu-baby.png", "KungFuBeebi": "res://Assets/CoolNames/kung-fu-baby.png", "TaekWonDooBeebi": "res://Assets/CoolNames/taekwondo-baby.png", "KarateBeebi": "res://Assets/CoolNames/karate-baby.png"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BeebiName.texture = load(beebi_coolnames[Globals.ChosenBeebi])
	$BeebiDescription.text = beebi_descriptions[Globals.ChosenBeebi]
	Globals.On_Babychanged.connect(ChangeBaby)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ChangeBaby(value):
	$BeebiName.texture = load(beebi_coolnames[value])
	$BeebiDescription.text = beebi_descriptions[value]


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
