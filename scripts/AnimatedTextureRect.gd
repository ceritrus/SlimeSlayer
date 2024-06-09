@tool
class_name AnimatedTextureRect extends TextureRect
@export var sprites : SpriteFrames
@export var current_animation = "full"
@export var frame_index := 0
@export_range(0.0, INF, 0.001) var speed_scale := 1.0
@export var auto_play := false
@export var playing := false
var refresh_rate = 1.0
var fps = 30.0
var frame_delta = 0

func _ready():
	get_animation_data(current_animation)
	if auto_play:
		play()
		
func change_animation(name :String):
	if sprites.has_animation(current_animation) == false:
		playing = false
		assert(false,"Animation %s, Doesnt Exist"  % current_animation)
	else:
		current_animation = name
		get_animation_data(current_animation)
		frame_index = 0
		texture = sprites.get_frame_texture(current_animation, 0)
	
func _process(delta):
	if sprites == null or playing == false:
		return
	if sprites.has_animation(current_animation) == false:
		playing = false
		assert(false,"Animation %s, Doesnt Exist"  % current_animation)
	get_animation_data(current_animation)
	frame_delta += (speed_scale *  delta)
	if frame_delta >= refresh_rate/fps:
		texture = get_next_frame()
		frame_delta = 0.0

func play(animation_name :String= current_animation):
	frame_index = 0
	frame_delta = 0.0
	current_animation = animation_name
	get_animation_data(current_animation)
	playing = true
	
func get_animation_data(animation):
	fps = sprites.get_animation_speed(current_animation)
	refresh_rate = sprites.get_frame_duration(current_animation,frame_index)
	
func get_next_frame():
	frame_index += 1
	var frame_count = sprites.get_frame_count(current_animation)
	if frame_index >= frame_count:
		if sprites.get_animation_loop(current_animation):
			frame_index = 0
		else:
			frame_index -= 1
	get_animation_data(current_animation)
	return sprites.get_frame_texture(current_animation,frame_index)

func resume():
	playing = true
	
func pause():
	playing = false
	
func stop():
	frame_index = 0
	playing = false
