extends Node2D

class_name Ball

var RANK
var POINTS

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("RigidBody2D").contact_monitor = true
	get_node("RigidBody2D").contacts_reported = 20

func _on_RigidBody2D_body_entered(body):
	var other_rank = body.get_parent().RANK
	if self.RANK == other_rank:
		Signals.merge(self, body.get_parent())	

func set_rank(val:int):
	RANK = val

func set_points(val:int):
	POINTS = val