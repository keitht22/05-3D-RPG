extends KinematicBody

onready var Dialogue = get_node("/root/Game/UI/Dialogue")

var dialogue = [
	"Press F to interact",
	"H e L L o!			W e l c oo me  too the GREAT PASTURE IN THE SKY! ...",
	"In order to gain HAPPYNESS, you G OT T A whack those weird monkee-sheap with that crook",
	"in your hands. Once your HAPPYNESS reaches 5, you'll win!"
]

func _ready():
	$AnimationPlayer.play("Idle")


func _on_Area_body_entered(_body):
	Dialogue.start_dialogue(dialogue)

func _on_Area_body_exited(_body):
	Dialogue.hide_dialogue()
