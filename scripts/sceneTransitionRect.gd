extends CanvasLayer
@export var next_scene_path : String
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func transition_to(next_scene := next_scene_path):
	animation_player.play("fade")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(next_scene)
	animation_player.play_backwards("fade")
