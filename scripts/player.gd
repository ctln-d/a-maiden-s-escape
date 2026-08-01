extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 250.0
const JUMP_VELOCITY = -850.0
var alive = true
var can_move = true


func _physics_process(delta: float) -> void:
	# Add animation.
	# if velocity.x > 1 or velocity.x < -1:
		# animated_sprite_2d.animation = "walk"
	# else:
	animated_sprite_2d.animation = "idle"
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		# animated_sprite_2d.animation = "jump"

	if can_move:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		
		if direction == 1.0:
			animated_sprite_2d.flip_h = false
		elif direction == -1.0:
			animated_sprite_2d.flip_h = true
		
func die() -> void:
	alive = false
	visible = false
	# can't move code here
	
	await get_tree().create_timer(1).timeout
	# reset_player()

# func reset_player() -> void:
	# get level _ (load level) start pos
	alive = true
	visible = true
	# can move code here
