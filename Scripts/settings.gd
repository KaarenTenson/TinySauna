extends Panel
@onready var vtext: Label = $Control/vtext
@onready var h_slider: HSlider = $Control/HSlider
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player.play()
	h_slider.value=50;
	audio_stream_player.volume_db=linear_to_db(h_slider.value/100)
	print(linear_to_db(h_slider.value/100))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_slider_value_changed(value: float) -> void:
	audio_stream_player.volume_db=linear_to_db(value/100)
	vtext.text=str(int(value))+"%";
