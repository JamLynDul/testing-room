extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flipping sprite based on direction
	if direction > 0:
		animated_sprite_2d.flip_h = true
	elif direction< 0:
		animated_sprite_2d.flip_h = false
	
	
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("running")
	else: # in case the character falls for longer
		if velocity.y < 0:
			animated_sprite_2d.play("jumping_up") 
		else:
			animated_sprite_2d.play("falling")
	
	
	
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
