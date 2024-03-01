extends Node2D


@onready var player_spawn_position = $PlayerSpawnPosition

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	
	player.global_position = player_spawn_position.global_position

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
