extends KinematicBody

export var speed = 100

var target  #what we are looking at
var space_state

func _ready():
	space_state = get_world().direct_space_state

func _physics_process(delta):
	if target:
		#if enemy can make a ray cast from here to the target
		#	ie: enemy can see target
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		#and it is a player
		if (result.collider.is_in_group("Player")):
			#look at it
			#note: look_at works by moving the -z axis of the object towards the target
			look_at(target.global_transform.origin, Vector3.UP)
			move_to_target(delta)

func _on_VeiwCone_body_entered(body):
	if (body.is_in_group("Player")):
		target = body
		print (body.name + " entered")

func _on_VeiwCone_body_exited(body):
	if (body.is_in_group("Player")):
		print (body.name + " left")
		target = null

func move_to_target(delta):
	#gets the direction to the target
	#	w/out normalized, it returns an array, w/ it just returns direction
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)
	
