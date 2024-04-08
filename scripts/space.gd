extends Node2D

@export var space_junk_scenes: Array[PackedScene] = []
@export var asteroid_scenes: Array[PackedScene] = []

@onready var player_spawn_position = $PlayerSpawnPosition
@onready var laser_container = $LaserContainer
@onready var space_junk_container = $SpaceJunkContainer
@onready var asteroid_container = $AsteroidContainer
@onready var hud = $UILayer/HUD
@onready var game_over_screen = $UILayer/GameOverScreen
@onready var asteroid_spawn_timer = $AsteroidSpawnTimer
@onready var space_junk_spawn_timer = $SpaceJunkSpawnTimer
@onready var parallax_background = $ParallaxBackground

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
var high_score := 0
var scroll_speed = 70

func _ready():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	
	score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	
	player.global_position = player_spawn_position.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.destroyed.connect(_on_player_destroyed)
	
func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if asteroid_spawn_timer.wait_time > 0.3:
		asteroid_spawn_timer.wait_time -= delta * 0.02
	if space_junk_spawn_timer.wait_time > 0.15:
		space_junk_spawn_timer.wait_time -= delta * 0.04
		
	parallax_background.scroll_offset.y += delta * scroll_speed
	
	if parallax_background.scroll_offset.y >= 648:
		parallax_background.scroll_offset.y = 0


func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)


func _on_space_junk_spawn_timer_timeout():
	var space_junk = space_junk_scenes.pick_random().instantiate()
	space_junk.global_position = Vector2(randf_range(10, 1140), -50)
	space_junk.destroyed.connect(_on_space_junk_destroyed)
	space_junk_container.add_child(space_junk)
	


func _on_asteroid_spawn_timer_timeout():
	var asteroid = asteroid_scenes.pick_random().instantiate()
	asteroid.global_position = Vector2(randf_range(10, 1140), -50)
	asteroid_container.add_child(asteroid)

func _on_space_junk_destroyed(points):
	score += points
	if score > high_score:
		high_score = score
	
func _on_player_destroyed():
	game_over_screen.set_score(score)
	game_over_screen.set_high_score(high_score)
	save_game()
	await get_tree().create_timer(1).timeout
	game_over_screen.visible = true
