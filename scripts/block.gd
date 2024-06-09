extends StaticBody2D
@onready var animation_player = $AnimationPlayer
@onready var spawner = $Spawner

const path: String = "res://scenes/fruit.tscn"
var scene = preload(path)
@export var quantity : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.velocity.y < -10 && quantity > 0:
		body.velocity.y = 0
		if quantity > 1:
			animation_player.play("hit")
			quantity -= 1
		elif quantity == 1:
			animation_player.play("empty")
			quantity = 0
		var temp = scene.instantiate()
		temp.position = spawner.position
		add_child(temp)
	pass # Replace with function body.
