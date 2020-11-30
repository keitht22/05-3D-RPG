extends KinematicBody

onready var Camera = get_node("/root/Game/Player/Camera")

var velocity = Vector3()
var gravity = -9.8
var speed = 0.4
var max_speed = 7

var mouse_sensitivity = 0.002

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$AnimationTree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	velocity.y += gravity * _delta
	var falling = velocity.y
	velocity.y = 0
	
	var desired_velocity = get_input() * speed
	if desired_velocity.length():
		velocity += desired_velocity
	else:
		velocity *= 0.3
	
	var current_speed = velocity.length()
	velocity = velocity.normalized() * clamp(current_speed, 0, max_speed)
	velocity.y = falling
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	$AnimationTree.set("parameters/Idle_Run/blend_amount", current_speed/max_speed)
	if Input.is_action_just_pressed("interact"):
		$AnimationTree.active = false
		$AnimationPlayer.play("Attack")
		$grunt.play()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir -= Camera.global_transform.basis.z
	if Input.is_action_just_pressed("backwards"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_just_pressed("turn_left"):
		input_dir -= Camera.global_transform.basis.x
	if Input.is_action_just_pressed("turn_right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir


func _on_AnimationPlayer_animation_finished(_Attack):
	$AnimationTree.active = true
