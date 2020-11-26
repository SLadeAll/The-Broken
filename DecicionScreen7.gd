extends Node
var i = 0
export (int) var Results
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	
func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton.is_hovered() ==true:
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton2.is_hovered() ==true:
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton2.grab_focus()


func _on_TextureButton_pressed():
	Results = 25 
	get_tree().change_scene("res://Town.tscn")
	return Results 


func _on_TextureButton2_pressed():
	Results = 10 

	get_tree().change_scene("res://Town.tscn")
	return Results 
