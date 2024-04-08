extends Node2D


@onready var player_spawn_position = $PlayerSpawnPosition
@onready var laser_container = $LaserContainer

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	
	player.global_position = player_spawn_position.global_position
	player.laser_shot.connect(_on_player_laser_shot)

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
