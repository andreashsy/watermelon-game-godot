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
	
	if Input.is_action_pressed("ui_up"):
		var obj_instance = circle.instance()
		add_child(obj_instance)
