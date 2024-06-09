extends CharacterBody2D
class_name Player

@export var maxHealth = 3
@export var maxJumps = 2
var jumps_left
var health = 3
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var alive = true

@onready var healthbar = $"../CanvasLayer/Control/Healthbar"
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer

func _ready():
	health = maxHealth
	healthbar.initialize(maxHealth)
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumps_left = maxJumps

	if alive == true:
		# Handle jump.
		if Input.is_action_just_pressed("jump") && jumps_left > 0:
			jumps_left -= 1
			velocity.y = JUMP_VELOCITY
			animated_sprite.play("jump")
			animated_sprite.frame = 0

		# Get the input direction: -1, 0, 1
		var direction = Input.get_axis("move_left", "move_right")
		
		# Flip the sprite
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		# Play animations
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
	
		# Apply movement
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func die():
	alive = false
	animated_sprite.play("die")
	velocity.y = JUMP_VELOCITY * 0.75
	Engine.time_scale = 0.4
	get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	 
func hit(value):
	health -= value
	healthbar.hurt(value)
	if health <= 0:
		health = 0
		die()

func heal(value: int):
	health += value
	if health > maxHealth:
		health = maxHealth
	else:
		healthbar.heal(value)
