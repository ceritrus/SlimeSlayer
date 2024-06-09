extends HBoxContainer
class_name Healthbar

const path: String = "res://scenes/heart.tscn"
var scene = preload(path)
var total_life: int
var current_life: int
var hearts: Array[TextureRect]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func heal(value :int = 1):
	if current_life == total_life:
		total_life += 1
		hearts.resize(total_life)
		hearts[current_life] = scene.instantiate()
		add_child(hearts[current_life])
	hearts[current_life].change_animation("full")
	current_life += 1

func hurt(value :int = 1):
	print("Healthbar: hurt")
	hearts[current_life - 1].change_animation("empty")
	if current_life > 0:
		current_life -= 1

func initialize(value :int = 3):
	total_life = value
	current_life = value
	hearts.resize(value)
	for x in range(value):
		hearts[x] = scene.instantiate()
		hearts[x].change_animation("full")
		add_child(hearts[x])
