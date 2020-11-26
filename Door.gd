extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var next_scene = preload("res://insideCastle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_body_entered(body):
	if body.get_name() == "Player1":
		get_tree().change_scene_to(next_scene)
	pass # Replace with function body.
