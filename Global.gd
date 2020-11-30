extends Node

onready var score = 0

func _process(_delta):
	if score >= 5:
		get_tree().change_scene("Victory")

func _input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func add_score(s):
	score += s
	get_node("/root/Game/UI/Score").text = "Animals Herded: " + str(score)
