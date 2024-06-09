extends Area2D
@onready var timer = $Timer
@onready var death = $Death


func _on_body_entered(body):
	Engine.time_scale = 0.4
	body.get_node("CollisionShape2D").queue_free()
	body.die()
	death.play()
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
