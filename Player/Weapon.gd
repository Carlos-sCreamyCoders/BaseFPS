extends Node

export var fireTime = 0.5
export var magSize = 5
export var reloadTime = 1

var currentAmmo = magSize
var canFire = true
var isReloading = false

func _process(delta):
	if Input.is_action_just_pressed("primary_fire") and canFire:
		#fire da wheapon
		if currentAmmo > 0 and not isReloading:
			print("Yatatatatatatata")
			canFire = false
			currentAmmo -= 1
			yield(get_tree().create_timer(fireTime), "timeout")
			canFire = true
	
	if Input.is_action_just_pressed("reload") and not isReloading:
		isReloading = true
		print("Reloading")		
		yield(get_tree().create_timer(reloadTime), "timeout")
		currentAmmo = magSize
		isReloading = false
		print("Gatof")
