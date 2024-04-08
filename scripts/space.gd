extends Node2D

@export var space_junk_scenes: Array[PackedScene] = []
@export var asteroid_scenes: Array[PackedScene] = []

@onready var player_spawn_position = $PlayerSpawnPosition
@onready var laser_container = $LaserContainer
@onready var space_junk_container = $SpaceJunkContainer
@onready var asteroid_container = $AsteroidContainer
@onready var hud = $UILayer/HUD

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score

func _ready():
	score = 0
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


func _on_space_junk_spawn_timer_timeout():
	var space_junk = space_junk_scenes.pick_random().instantiate()
	space_junk.global_position = Vector2(randf_range(100, 1000), -50)
	space_junk.destroyed.connect(_on_space_junk_destroyed)
	space_junk_container.add_child(space_junk)
	


func _on_asteroid_spawn_timer_timeout():
	var asteroid = asteroid_scenes.pick_random().instantiate()
	asteroid.global_position = Vector2(randf_range(100, 1000), -50)
	asteroid_container.add_child(asteroid)

func _on_space_junk_destroyed(points):
	score += points
