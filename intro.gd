extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pass # Replace with function body.


func _on_skip_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
