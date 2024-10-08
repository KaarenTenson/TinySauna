extends Control
@onready var panel: Panel = $Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/hub.tscn")
	$AudioStreamPlayer2.play()
	


func _on_exit_pressed() -> void:
	get_tree().quit()
	$AudioStreamPlayer2.play()


func _on_settings_pressed() -> void:
	panel.visible=true
	$AudioStreamPlayer2.play()

func _on_button_pressed() -> void:
	panel.visible=false
	$AudioStreamPlayer2.play()


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
	pass # Replace with function body.
