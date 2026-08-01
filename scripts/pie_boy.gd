extends Node2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

signal player_died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Dough/AnimationPlayer.play("intro")
	$Dough/AnimationPlayer.queue("loop")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.alive:
		emit_signal("player_died", body)


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "toss":
		sprite.play("hit")
