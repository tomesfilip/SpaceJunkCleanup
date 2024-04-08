class_name SpaceJunk extends Area2D

@export var speed = 150

func _physics_process(delta):
	global_position.y += speed * delta
	
func destroy():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.destroy()
		destroy()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
