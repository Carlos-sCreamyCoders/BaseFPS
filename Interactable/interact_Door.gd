extends Interactable

var isOpen = false
var isOpening = false
var isLocked = false

func interact():
	if (isLocked):
		null
	elif (!isOpen):
		open()
	else:
		close()

func open():
	isOpening = true
	#TODO: make open and close
	print("opening")
	isOpen = true
func close():
	isOpening = false
	print('closing')
	isOpen = false

func get_interaction_text():
	if (isLocked):
		return ""
	elif (!isOpen):
		return "open"
	else:
		return "close"
