extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.Get_Skill_Points()
	Globals.reset_Score()
	$AudioStreamPlayer2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/hub.tscn")
