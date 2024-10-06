extends Control

@onready var first_label = $first_key/Label
@onready var second_label = $second_key/Label

func change_labels(key1, key2):
	first_label.text = key1
	second_label.text = key2
