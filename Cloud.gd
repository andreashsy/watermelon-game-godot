extends KinematicBody2D

var golf = preload("res://BallScenes/GolfBall.tscn")
var tennis = preload("res://BallScenes/TennisBall.tscn")
var pool = preload("res://BallScenes/PoolBall.tscn")
var base = preload("res://BallScenes/BaseBall.tscn")
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_ball()

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 40
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 40
	
	velocity.x = lerp(velocity.x, 0, 0.1)
	position += velocity * delta
	
	position.x = clamp(position.x, 500, 850)
	
	if Input.is_action_just_pressed("ui_up"):
		generate_ball()
			
	if Input.is_action_just_pressed("ui_down"):
		release_ball()


func generate_ball():
	if get_child_count() == 2:
		randomize()
		var balls = [golf, tennis, pool, base]
		var random_ball = balls[randi()%balls.size()]

		var obj_instance = random_ball.instance()
		obj_instance.get_node("RigidBody2D").mode = RigidBody2D.MODE_STATIC
		add_child(obj_instance)

func release_ball():
	var children = get_children()
	var isLastElementNode2D = children.back().get_class() == "Node2D"
	if isLastElementNode2D:
		var child_node = children.back()
		var grandparent_node = get_parent()
		
		remove_child(child_node)
		grandparent_node.add_child(child_node)

		grandparent_node.get_node("NoTouchZone").monitoring = false
		grandparent_node.get_node("TimerActivateNoTouchZone").start()

		child_node.get_node("RigidBody2D").mode = RigidBody2D.MODE_RIGID
		child_node.position = position
