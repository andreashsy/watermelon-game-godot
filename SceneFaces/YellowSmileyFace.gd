extends Node2D

var RANK = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("RigidBody2D").contact_monitor = true
	get_node("RigidBody2D").contacts_reported = 20
 
func _on_RigidBody2DYellowSmileyFace_body_entered(body):
	var other_rank = body.get_parent().RANK
	if self.RANK == other_rank:
		Signals.merge(self, body.get_parent())
