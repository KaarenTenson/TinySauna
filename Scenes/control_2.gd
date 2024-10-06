extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_box_container_mouse_entered() -> void:
	$ColorRect.visible = true
	$ColorRect/SkillDescription.text = "Decreases the rate at which keys disappear"


func _on_h_box_container_mouse_exited() -> void:
	$ColorRect.visible = false
	$ColorRect/SkillDescription.text = ""


func _on_h_box_container_2_mouse_entered() -> void:
	$ColorRect.visible = true
	$ColorRect/SkillDescription.text = "Decreases the rate at which keys appear"


func _on_h_box_container_2_mouse_exited() -> void:
	$ColorRect.visible = false
	$ColorRect/SkillDescription.text = ""


func _on_h_box_container_3_mouse_entered() -> void:
	$ColorRect.visible = true
	$ColorRect/SkillDescription.text = "Increases health regeneration"


func _on_h_box_container_3_mouse_exited() -> void:
	$ColorRect.visible = false
	$ColorRect/SkillDescription.text = ""
