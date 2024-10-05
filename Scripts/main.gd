extends Control

var tahed = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","Y","X","1","2","3",
"4","5","6","7","8","9","0"]
var mangiv =[]
var texture = preload("res://Assets/Buttons/C Buttons Small1.png")
#popup stseen
var target_key=preload("res://Scenes/Keys.tscn")

var explosions=preload("res://Assets/Particles/particle_effects/explosion.tscn")
var fades=preload("res://Assets/Particles/particle_effects/fade.tscn")

var fades_factory
var explosions_factory
@onready var score: Label = $Score
@onready var multi_plier: Label = $MultiPlier
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

#ehitatud popupstseen
var target_key_factory
#popupid, mis on ekraanil
var visible_keys=[]
#mitme sekundi tagant havitatkse popup
var havita_vahe=3
#mitme sekundi tagant tehakse 
var tee_vahe=2
#jalgib, kas saab teha popupe või hävitada neid
var timer_havita=0
var timer_tee=0
func kaotus():
	score.text="kaotus"
	set_process(false)
	print("kaotsid")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.On_Hp0.connect(kaotus)
	Globals.On_HpChanged.connect(func(value): texture_progress_bar.value=value)
	set_process_input(true)
	#kloonides saab popupe teha
	target_key_factory=target_key.instantiate()
	fades_factory=fades.instantiate()
	explosions_factory=explosions.instantiate()
	#taidab suvaliste charidega
	taida(1000)
	
func _input(event):
	# Check if the input is a key event
	if event is InputEventKey:
		if event.pressed:  # When a key is pressed down
			var key_name = event.as_text()  # Get the human-readable key name
			if(key_name=="Escape"):
				get_tree().paused = !get_tree().paused
				$Panel.visible=true
				
			#vaatab, kas vajutatud klahv on ekraanil
			for node in visible_keys:
				if !is_instance_valid(node):
					visible_keys.erase(node)
				elif(node.get_node("Label").text==key_name):
					#klahv on olemas, suurendab skoori ja selle multiplierit
					
					Globals.Add_Score()
					Globals.Inc_Multiplier()
					#havitab vajutatud klahvi masiivist 
					visible_keys.pop_at(visible_keys.find(node)).Destroy_Self()
					break
			
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(mangiv.size()==0 and visible_keys.size()==0):
		print("Game Over")
	if(timer_tee<=0):
		var tempobj=(teepopup(mangiv.pop_back()))
		visible_keys.append(tempobj)
		timer_tee=tee_vahe
	else:
		timer_tee-=delta
	score.text="Score: "+str(Globals.Score)
	multi_plier.text="multiplier: "+str(snapped(Globals.Score_Multiplier,0.01))

# teeb masiivi, kus suavlisi tähti ja numbreid võtta
func taida(suurus) -> Array:
	for i in range(suurus):
		mangiv.append(tahed.pick_random())
	return mangiv

#teeb popup haitab ennast enda skriptis kui piisavalt aega on möödas
func teepopup(taht) -> TextureRect:
	var uus=target_key_factory.duplicate()
	var vanem=self
	var random_x = randf_range((vanem.position.x+vanem.size.x*0.2), (vanem.position.x + vanem.size.x)*0.8)  # Adjust range as needed
	var random_y = randf_range((vanem.position.y+vanem.size.y*0.2), (vanem.position.y + vanem.size.y)*0.8)  # Adjust range as needed
	var suurus = size.x * 0.06
	uus.size=Vector2(suurus,suurus)
	uus.timer=havita_vahe
	uus.get_node("Label").text = taht
	# Set the new random position to the cloned node
	uus.position = Vector2(random_x, random_y)
	uus.Removed.connect(Effect)
	
	# Add the new node to the scene as a child of the parent
	vanem.add_child(uus)
	return uus
func Effect(Tposition):
	
	var explosion_temp: Node2D=explosions_factory.duplicate()
	var fade_temp: Node2D=fades_factory.duplicate()
	add_child(fade_temp)
	add_child(explosion_temp)
	fade_temp.set_position(Tposition)
	explosion_temp.set_position(Tposition)
	var emitter=fade_temp.get_children()[randi() % 4]
	var emitter2=explosion_temp.get_children()[randi() % 4]
	emitter.scale *= 60  # Scale the whole particle system
	emitter.amount *= 60  # Increase the number of particles
	#emitter.emitting=true
	emitter2.scale *= 10  # Scale the whole particle system
	emitter2.scale_amount_min=0.5
	emitter2.scale_amount_max=1
	emitter2.amount *= 2  # Increase the number of particles
	emitter2.emission_sphere_radius*=0.5
	emitter2.emitting=true
	
