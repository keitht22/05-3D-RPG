extends Spatial

onready var tween = get_node("/root/Game/Sheep/Tween")
onready var call = get_node("call")
onready var crook = get_node("/root/Game/Player/Root/Skeleton/BoneAttachment/crook/Crook") 
onready var global = get_node("/root/Global")

var target_pos = Vector3(-13.0, -4.0, 8.0)

func _ready():
	pass


func _physics_process(_delta):
	pass



func move_sheep():
		tween.interpolate_property(self, "translation", self.global_transform.origin, target_pos, 5, tween.TRANS_BOUNCE, tween.EASE_OUT)
		tween.start()



func _on_Area_body_entered(body):
	call.play()
	if body == crook:
		call.play()
		move_sheep()
		global.add_score(1)
