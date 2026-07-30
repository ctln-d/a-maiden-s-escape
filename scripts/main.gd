extends Node

var level: int = 1
var current_level_root: Node = null
var gems: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()
	# Setup level
	current_level_root = get_node("LevelRoot")


func _setup_level() -> void:
	# Connect gemstones
	var gemstones = $LevelRoot.get_node_or_null("Gemstones")
	if gemstones:
		for gemstone in gemstones.get_children():
			gemstone.collected.connect(_increase_gems)
	
	# Connect enemies
	var enemies = $LevelRoot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)


# Signal handlers
func _on_player_died(body):
	body.die()
	print("Player Killed")

func _increase_gems() -> void:
	gems += 1
	print(gems)

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		print(level)
		body.can_move = false
		call_deferred("_load_level",level)
		
