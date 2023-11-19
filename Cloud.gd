extends KinematicBody2D

var circle = preload("res://YellowSmileyFace.tscn")
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 40
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 40
	
	velocity.x = lerp(velocity.x, 0, 0.1)
	position += velocity * delta
	
	position.x = clamp(position.x, 500, 850)
	
	if Input.is_action_just_pressed("ui_up"):
		if get_child_count() == 2:
			var obj_instance = circle.instance()
			obj_instance.get_node("RigidBody2DYellowSmileyFace").gravity_scale = 0
			add_child(obj_instance)
		else:
			print("node already present")
			
	if Input.is_action_just_pressed("ui_down"):
		if get_child_count() > 2:
			var child_node = get_child(2)
			
			print("Got child: " + str(child_node.name))
			
			var grandparent_node = get_parent()
			remove_child(child_node)
			grandparent_node.add_child(child_node)
			child_node.get_node("RigidBody2DYellowSmileyFace").gravity_scale = 1
			child_node.position = position
			
