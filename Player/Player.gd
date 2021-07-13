extends KinematicBody

#vars that are able to be changed in the editor
export var speed = 10
export var accel = 5
export var gravity = 0.98
export var jumpPower = 30
export var mouseSensitivity = 0.3

#asigns the vars when it is loaded
onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var cameraXroatation = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouseSensitivity))
		var xDelta = event.relative.y * mouseSensitivity
		if cameraXroatation + xDelta > -90 and cameraXroatation + xDelta < 90:
			camera.rotate_x(deg2rad(-xDelta))
			cameraXroatation += xDelta
		if cameraXroatation < -90:
			cameraXroatation = -90
		if cameraXroatation > 90:
			cameraXroatation = 90

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	var direction = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z  #forward = -z in godot
	elif Input.is_action_pressed("move_back"):
		direction += head_basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	
	#direction = direction.normalize()  #optional
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jumpPower
	velocity = move_and_slide(velocity, Vector3.UP)
	
	
