extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.reset_Score()
	Globals.reset_skills()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_end_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pass # Replace with function body.
