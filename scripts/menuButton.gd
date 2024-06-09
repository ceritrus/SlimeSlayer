extends Control
@export var text : String = "  PLAY"
@export var icon : CompressedTexture2D
@export var onPress : String = "menu"

@onready var click_sound = $ClickSound
@onready var hover_sound = $HoverSound
@onready var animation_player = $AnimationPlayer
@onready var button = $Container/Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.text = "  " + text
	button.icon = icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_mouse_entered():
	hover_sound.play()
	animation_player.play("expand")
	pass # Replace with function body.

func _on_button_mouse_exited():
	animation_player.play("fold")
	pass # Replace with function body.

func _on_button_pressed():
	click_sound.play()
	SceneManager.handle_path(onPress)
	pass # Replace with function body.
