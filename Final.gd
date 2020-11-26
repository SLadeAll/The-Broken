extends Node
var i = 0
var res0 = get_node("DecicionScreen").Results
var res1 = get_node("DecicionScreen1").Results
var res2 = get_node("DecicionScreen2").Results
var res3 = get_node("DecicionScreen3").Results
var res4 = get_node("DecicionScreen4").Results
var res5 = get_node("DecicionScreen5").Results
var res6 = get_node("DecicionScreen6").Results
var res7 = get_node("DecicionScreen7").Results
var res8 = get_node("DecicionScreen8").Results
var res9 = get_node("DecicionScreen9").Results
var resF = res1 + res2 + res3 + res4 + res5 + res6 + res7 + res8 + res9 

func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	get_node("Label").text = str("Tu resultado final es de :" + resF )

# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton.is_hovered() ==true:
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton2.is_hovered() ==true:
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton2.grab_focus()


func _on_TextureButton_pressed():
	get_tree().quit()


func _on_TextureButton2_pressed():
	get_tree().quit()
