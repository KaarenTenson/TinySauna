extends Control

var tahed=["a","b","c","d","e","d","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","y","x","1","2","3",
"4","5","6","7","8","9","0"]
var mangiv =[]
var texture = preload("res://Assets/Buttons/C Buttons Small1.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	teepopup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func taida(suurus) -> Array:
	for i in range(suurus):
		mangiv.append(tahed.pick_random())
	return mangiv
func teepopup():
	var texture_rect = TextureRect.new()
	texture_rect.texture = texture
	 # Set minimum size (if needed)
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED  # Stretch mode
	add_child(texture_rect)
	
