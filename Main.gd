extends Node2D

var circle = preload("res://Circle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var circle_instance = circle.instance()
	circle_instance.position = Vector2(800, 0)
	
	add_child(circle_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
