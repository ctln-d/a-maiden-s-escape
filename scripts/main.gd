extends Node

var level: int = 1
var current_level_root: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()
	# Setup level
	current_level_root = get_node("LevelRoot")


func _setup_level() -> void:
	# Connect enemies
	var enemies = $LevelRoot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)


# Signal handlers
func _on_player_died(body):
	print(body)
	print("Player Killed")

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		print(level)
		body.can_move = false
		call_deferred("_load_level",level)
		
