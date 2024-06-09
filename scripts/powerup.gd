class_name PowerUp
extends CharacterBody2D

@export var speed = 50
@export var jump_velocity = -150
var direction = 1.0
var picked_up : bool = false

var rng = RandomNumberGenerator.new() 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.5
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight

func on_pickup(body):
	print("On_Pickup function must be implemented")
	pass # Replace with function body.

func _on_pickup_hitbox_body_entered(body):
	if not picked_up:
		picked_up = true
		on_pickup(body)
	
func _ready():
	if rng.randi() % 2 == 0:
		print("Going left!")
		direction = -1.0
	velocity.y = jump_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > 1000:
		queue_free()
	
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if ray_cast_left.is_colliding():
		direction = 1.0
	elif ray_cast_right.is_colliding():
		direction = -1.0
		
	velocity.x = speed * direction
	
	move_and_slide()

