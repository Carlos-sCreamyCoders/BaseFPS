extends RayCast

var currentCollider
onready var interaction_lable = get_node("/root/World/UI/Interact")

func _ready():
	set_interaction_text("")


func _process(delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if currentCollider != collider:
			set_interaction_text(collider.get_interaction_text())
			currentCollider = collider
		
		if Input.is_action_just_pressed("Interact"):
			collider.interact()  #calls the object's interact function
			set_interaction_text(collider.get_interaction_text())
		
	elif currentCollider:  #if your not looking at an interactable
		set_interaction_text("")
		currentCollider = null  #empty current collider
	
func set_interaction_text(text):
	if !text:
		interaction_lable.set_text("")
		interaction_lable.set_visible(false)
	else:
		var interact_key = OS.get_scancode_string(InputMap.get_action_list("Interact")[0].scancode)
		interaction_lable.set_text("Press %s to %s" % [interact_key, text])
		interaction_lable.set_visible(true)
