extends RayCast

var currentCollider

func _process(delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if currentCollider != collider:
			currentCollider = collider
		
		if Input.is_action_just_pressed("Interact"):
			collider.interact()  #calls the object's interact function
		
	elif currentCollider:  #if your not looking at an interactable
		currentCollider = null  #empty current collider
	
