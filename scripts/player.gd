class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)
signal destroyed

@export var speed = 300.0

@onready var muzzle = $Muzzle

var laser_scene = preload("res://scenes/laser.tscn")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), 
							Input.get_axis("move_up", "move_down"))
	
	velocity = direction * speed
	move_and_slide()
	
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)
	
func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)
	
func destroy():
	destroyed.emit()
	queue_free()
