class_name SpaceJunk extends Area2D

signal destroyed(points)
signal hit

@export var speed = 150
@export var hp = 1
@export var points = 100

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

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		destroyed.emit(points)
		destroy()
	else:
		hit.emit()
