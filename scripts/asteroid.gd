class_name Asteroid extends Area2D

@export var speed = 100

func _physics_process(delta):
	global_position.y += speed * delta
	
func destroy():
	queue_free()


func _on_body_entered(body):
	if body is Player:
		body.destroy()
		destroy()
