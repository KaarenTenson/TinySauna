extends Control

var tahed = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","Y","X","1","2","3",
"4","5","6","7","8","9","0"]
var mangiv =[]
var hold_letters = ["", ""]
var texture = preload("res://Assets/Buttons/C Buttons Small1.png")

# keys for holding down
var key1 = ""
var key2 = ""
# last rotation keys for holding down
var last_key1 = ""
var last_key2 = ""

#popup stseen
var target_key=preload("res://Scenes/Keys.tscn")

var explosions=preload("res://Assets/Particles/particle_effects/explosion.tscn")
var fades=preload("res://Assets/Particles/particle_effects/fade.tscn")

var fades_factory
var explosions_factory
@onready var score: Label = $Score
@onready var multi_plier: Label = $MultiPlier
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var crowd_anim = $Crowd/crowd_hype
@onready var boom_sound = $Random_Boom
@onready var music = $Main_Soundtrack

# key on screen timer
@onready var timer = $Gameplay_Timers/hold_wait
# key held down timer
@onready var timer_held = $Gameplay_Timers/hold_down_wait

# hold keys controller
@onready var hold_keys_controller = $Hold_Keys_Controller

# crowd aanimation speed
var anim_speed = 0
#ehitatud popupstseen
var target_key_factory
#popupid, mis on ekraanil
var visible_keys=[]
#mitme sekundi tagant havitatkse popup
var havita_vahe=2
#mitme sekundi tagant tehakse 
var tee_vahe=2
#jalgib, kas saab teha popupe või hävitada neid
var timer_havita=0
var timer_tee=0
var previous_key=""

var holdtimer=30
var hold_time=false
var hold_count=4
var damage_timer=0

# gameplay switch
var first = true
var second = false
var third = false
var fourth = false
var fifth = false
var sixth = false

# was wrong letter pressed
var misinput = false
# did the hold_wait timer run out
var timeout = false
# did the hold_down_wait timer run out
var timeout_held = false

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
	target_key_factory = target_key.instantiate()
	fades_factory=fades.instantiate()
	explosions_factory=explosions.instantiate()
	#taidab suvaliste charidega
	taida(1000)
	# sets crowd animation speed to 0 and plays it
	crowd_anim.speed_scale = anim_speed
	crowd_anim.play("hype")
	music.play()

func _input(event):
	# Check if the input is a key event
	if event is InputEventKey:
		if event.pressed:  # When a key is pressed down
			var key_name = event.as_text()  # Get the human-readable key name
			if(key_name=="Escape"):
				get_tree().paused = !get_tree().paused
				$Panel.visible=true
			#vaatab, kas vajutatud klahv on ekraanil
			if (first):
				for node in visible_keys:
					if !is_instance_valid(node):
						visible_keys.erase(node)
					elif (node.get_node("Label").text == key_name):
						#klahv on olemas, suurendab skoori ja selle multiplierit
						Globals.Add_Score()
						Globals.Inc_Multiplier()
						# havitab vajutatud klahvi masiivist 
						visible_keys.pop_at(visible_keys.find(node)).Destroy_Self()
						var tempobj=(teepopup(mangiv.pop_back()))
						visible_keys.append(tempobj)
						timer_tee = tee_vahe
						boom_sound.play()
						break
					#vale klahv on vajutatud
					if(damage_timer<=0):
						damage_timer = 0.5
						Globals.Recive_Damage()
						Globals.Dec_Multiplier()
			# When we are in second phase and the timer is ticking
			if (second and !timeout):
				# When both right keys are held down
				if (Input.is_action_pressed(key1) and Input.is_action_just_pressed(key2)):
					print("correct combination")
					timer.paused = true
					timer_held.start(0)
					return
				# When both of the pressed keys are wrong
				#if (!Input.is_action_pressed(key1) and !Input.is_action_pressed(key2)):
				#	timer_held.stop()
				#	Globals.Recive_Damage()
				#	Globals.Dec_Multiplier()
				#	timeout = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	combo_checker()
	score.text="Score: "+str(Globals.Score)
	multi_plier.text="multiplier: "+str(snapped(Globals.Score_Multiplier,0.01))
	#holdi jaoks, suht palju peab veel panema 
	if(holdtimer<0):
		if(holdtimer<(-(havita_vahe+1))):
			for i in range(2):
				var key=mangiv.pop_back()
				while key==previous_key:
					key=mangiv.pop_back()
				var tempobj=(teepopup(key))
				visible_keys.append(tempobj)
			hold_time=true
		return
	#kas manija võitis
	if(mangiv.size()==0 and visible_keys.size()==0):
		print("Game Over")
	#kas tehakse uus popup
	if (first):
		if(timer_tee <= 0):
			var tempobj = (teepopup(mangiv.pop_back()))
			visible_keys.append(tempobj)
			timer_tee=tee_vahe
		else:
			timer_tee-=delta
		if(damage_timer>0):
			damage_timer-=delta
	if (second):
		# When the timer runs out
		if (timeout):
			timeout = false
			Globals.Dec_Multiplier()
			Globals.Recive_Damage()
			next_hold_keys()
			timer.start(0)
		# When the timer hasn't timed out, but both keys were held for x time
		if (!timeout and timeout_held):
			timeout_held = false
			timer.paused = false
			Globals.Add_Score()
			Globals.Inc_Multiplier()
			next_hold_keys()
			timer.start(0)
			last_key1 = key1
			last_key2 = key2
			return
		# When one of the right keys are released
		if (Input.is_action_just_released(key1) or Input.is_action_just_released(key2)):
			timer.paused = false
			timer_held.stop()
			Globals.Dec_Multiplier()
			Globals.Recive_Damage()
			next_hold_keys()
			timer.start(0)

# teeb masiivi, kus suavlisi tähti ja numbreid võtta
func taida(suurus) -> Array:
	for i in range(suurus):
		mangiv.append(tahed.pick_random())
	return mangiv

func next_hold_keys():
	# brand new key1
	while (true):
		key1 = tahed.pick_random()
		while (key1 == last_key1 or key1 == last_key2):
			key1 = tahed.pick_random()
		# brand new key2
		key2 = tahed.pick_random()
		while (key2 == last_key1 or key2 == last_key2):
			key2 = tahed.pick_random()
		if (key1 != key2):
			break
	# change key labels
	hold_keys_controller.change_labels(key1, key2)
	# random position for hold keys
	var x = randf_range(105, 600)
	var y = randf_range(60, 285)
	hold_keys_controller.position = Vector2(x, y)
	hold_keys_controller.visible = true

#teeb popup haitab ennast enda skriptis kui piisavalt aega on möödas
func teepopup(taht) -> TextureRect:
	var uus = target_key_factory.duplicate()
	var vanem = self
	var random_x = randf_range((vanem.position.x+vanem.size.x*0.2), (vanem.position.x + vanem.size.x)*0.8)  # Adjust range as needed
	var random_y = randf_range((vanem.position.y+vanem.size.y*0.2), (vanem.position.y + vanem.size.y)*0.8)  # Adjust range as needed
	var suurus = size.x * 0.06
	uus.size=Vector2(suurus,suurus)
	uus.timer = havita_vahe
	uus.get_node("Label").text = taht
	# Set the new random position to the cloned node
	uus.position = Vector2(random_x, random_y)
	uus.Removed.connect(Effect)
	
	# Add the new node to the scene as a child of the parent
	vanem.add_child(uus)
	return uus

#particle effektide lisamine, kui popup havitatkse
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

# Checks how many correct inputs straight,
# ramps up crowd animation speed according to combo
func combo_checker():
	var current_combo = Globals.get_combo()
	anim_speed = current_combo / 5
	if (anim_speed <= 6):
		crowd_anim.speed_scale = anim_speed

func _on_1st_switch_timeout():
	print("First Timeout")
	first = false
	second = true
	timer.start(0)

func _on_2nd_switch_timeout():
	print("Second Timeout")
	second = false
	third = true

func _on_3rd_switch_timeout():
	print("Third Timeout")
	third = false
	fourth = true

func _on_4th_switch_timeout():
	print("Fourth Timeout")
	fourth = false
	fifth = true

func _on_5th_switch_timeout():
	print("Fifth Timeout")
	fifth = false
	sixth = true

# When the music runs out (victory screen)
func _on_6th_switch_timeout():
	print("Sixth Timeout")
	sixth = false

# key on screen timer timeout (hold_wait)
func _on_timer_timeout():
	timeout = true

# waits til keys are held down (hold_down_wait)
func _on_hold_down_wait_timeout():
	timeout_held = true
