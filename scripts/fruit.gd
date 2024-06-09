extends PowerUp
@onready var animation_player = $AnimationPlayer

func on_pickup(body):
	body.heal(1)
	animation_player.play("pickup")
