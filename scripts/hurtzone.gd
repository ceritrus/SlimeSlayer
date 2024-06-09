extends Area2D
@onready var timer = $Timer
@onready var hit = $Hit

func _on_body_entered(body):
	body.hit(1)
	hit.play()
	
