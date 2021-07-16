extends Spatial

class_name Weapon

export var fireTime = 0.5
export var magSize = 5
export var reloadTime = 1
export var fireRange = 100

export var defaultPosition : Vector3  #default weapon position
export var adsPosition : Vector3  #the position that the gun changes to when scoped in
export var adsAcceleration : float = 0.3
export var defaultFOV : float = 70  #what the normal camera is
export var adsFOV : float = 50

export var raycast_path : NodePath
export var mainCamera_path : NodePath
onready var ammoLabel = $"/root/World/UI/Ammo"

var raycast : RayCast
var mainCamera : Camera

var currentAmmo = 0
var canFire = true
var isReloading = false

func _ready():
	raycast = get_node(raycast_path)
	mainCamera = get_node(mainCamera_path)
	raycast.cast_to = Vector3(0, 0, -fireRange)
	currentAmmo = magSize

func _process(delta):
	if not isReloading:
		ammoLabel.set_text("%d / %d" % [currentAmmo, magSize])
	
	if Input.is_action_just_pressed("primary_fire") and canFire:
		if currentAmmo > 0 and not isReloading:
			fire()
	
	if Input.is_action_just_pressed("reload") and not isReloading:
		reload()
	
	if Input.is_action_pressed("secondary_fire"):
		#change from current position to ads position and fov
		transform.origin = transform.origin.linear_interpolate(adsPosition, adsAcceleration)
		mainCamera.fov = lerp(mainCamera.fov, adsFOV, adsAcceleration)
	else:
		transform.origin = transform.origin.linear_interpolate(defaultPosition, adsAcceleration)
		mainCamera.fov = lerp(mainCamera.fov, defaultFOV, adsAcceleration)
		


func checkColision():
	print("shot")
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed " + collider.name)

func fire():
	canFire = false
	currentAmmo -= 1
	checkColision()  #and destroy
	yield(get_tree().create_timer(fireTime), "timeout")
	canFire = true

func reload():
	isReloading = true
	ammoLabel.set_text("Reloading...")
	yield(get_tree().create_timer(reloadTime), "timeout")
	currentAmmo = magSize
	isReloading = false

