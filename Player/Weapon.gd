extends Node

class_name Weapon

export var fireTime = 0.5
export var magSize = 5
export var reloadTime = 1
export var fireRange = 100

onready var raycast = $"/root/World/Player/Head/Camera/RayCast"
onready var ammoLabel = $"/root/World/UI/Ammo"

var currentAmmo = 0
var canFire = true
var isReloading = false

func _ready():
	raycast.cast_to = Vector3(0, 0, -fireRange)
	currentAmmo = magSize

func _process(delta):
	ammoLabel.set_text("Hi")
	
	if Input.is_action_just_pressed("primary_fire") and canFire:
		#fire da wheapon
		if currentAmmo > 0 and not isReloading:
			print("Yatatatatatatata")
			canFire = false
			currentAmmo -= 1
			checkColision()
			yield(get_tree().create_timer(fireTime), "timeout")
			canFire = true
	
	if Input.is_action_just_pressed("reload") and not isReloading:
		isReloading = true
		print("Reloading")		
		yield(get_tree().create_timer(reloadTime), "timeout")
		currentAmmo = magSize
		isReloading = false
		print("Gatof")


func checkColision():
	print("yeeters")
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed " + collider.name)
