extends Camera

export var mainCamera_path : NodePath

var mainCamera : Camera

func _ready():
	mainCamera = get_node(mainCamera_path)

func _process(delta):
	global_transform = mainCamera.global_transform
