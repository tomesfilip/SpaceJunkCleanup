extends Control

@onready var parallax_background = $ParallaxBackground

var scroll_speed = 70

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/space.tscn")

func _process(delta):
	parallax_background.scroll_offset.y += delta * scroll_speed
	
	if parallax_background.scroll_offset.y >= 648:
		parallax_background.scroll_offset.y = 0
