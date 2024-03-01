extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), 
							Input.get_axis("move_up", "move_down"))
	
	velocity = direction * SPEED
	move_and_slide()	
	
	
