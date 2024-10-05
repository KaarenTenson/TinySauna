extends Control

var tahed=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","Y","X","1","2","3",
"4","5","6","7","8","9","0"]
var mangiv =[]
var texture = preload("res://Assets/Buttons/C Buttons Small1.png")
var target_key=preload("res://Scenes/Keys.tscn")
@onready var score: Label = $Score
var target_key_factory
var visible_keys=[]
var havita_vahe=5
var tee_vahe=1
var timer_havita=0
var timer_tee=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(true)
	target_key_factory=target_key.instantiate()
	taida(1000)
	
func _input(event):
	# Check if the input is a key event
	if event is InputEventKey:
		if event.pressed:  # When a key is pressed down
			var key_name = event.as_text()  # Get the human-readable key name
			for node in visible_keys:
				if !is_instance_valid(node):
					visible_keys.erase(node)
				elif(node.get_node("Label").text==key_name):
					Globals.Add_Score()
					Globals.Inc_Multiplier()
					visible_keys.pop_at(visible_keys.find(node)).Destroy_Self()
					break
			
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(timer_tee<=0):
		var tempobj=(teepopup(mangiv.pop_back()))
		visible_keys.append(tempobj)
		timer_tee=tee_vahe
	else:
		timer_tee-=delta
	score.text="Score: "+str(Globals.Score)
func taida(suurus) -> Array:
	for i in range(suurus):
		mangiv.append(tahed.pick_random())
	return mangiv
func teepopup(taht) -> TextureRect:
	var uus=target_key_factory.duplicate()
	var vanem=self
	var random_x = randf_range((vanem.position.x+vanem.size.x*0.2), (vanem.position.x + vanem.size.x)*0.8)  # Adjust range as needed
	var random_y = randf_range((vanem.position.y+vanem.size.y*0.2), (vanem.position.y + vanem.size.y)*0.8)  # Adjust range as needed
	var suurus=randf_range(40,80)
	uus.size=Vector2(suurus,suurus)
	uus.timer=havita_vahe
	uus.get_node("Label").text=taht
	# Set the new random position to the cloned node
	uus.position = Vector2(random_x, random_y)
	
	# Add the new node to the scene as a child of the parent
	vanem.add_child(uus)
	return uus
	
