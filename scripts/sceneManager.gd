extends Node

func load_main_menu():
	SceneTransitionRect.transition_to("res://scenes/menu.tscn")

func load_level_one():
	SceneTransitionRect.transition_to("res://scenes/game.tscn")

func load_options():
	SceneTransitionRect.transition_to("res://scenes/options.tscn")

func handle_path(text: String):
	if text == "menu":
		load_main_menu()
	elif text == "game":
		load_level_one()
	elif text == "options":
		load_options()
	elif text == "quit" || text == "exit":
		exit_game()
	
func exit_game():
	get_tree().quit()
