extends KinematicBody2D

onready var Player = get_parent().get_node("Player1")

var player = null
var isAttacking = false;
var velocity = Vector2();
var is_dead = false;

export (float) var max_health = 60;
onready var health = max_health 
var sword_Damage = 30
var SPEED = 100;
const GRAVITY = 100

const FLOOR = Vector2(0, -1)

func _physics_process(delta):
	if is_dead == false:
		get_node("./LifeCounter").text = str("HP: ", health, "%")
		if player != null:
			if Player.position.x < position.x:
				velocity.x = -SPEED
				$AnimatedSprite.play("Run")
				$AnimatedSprite.flip_h = true
				$CollisionShape2D.position.x = 14
				$DeathArea/CollisionShape2D.position.x = 14
			elif Player.position.x > position.x:
				velocity.x = SPEED
				$AnimatedSprite.play("Run")
				$AnimatedSprite.flip_h = false
				$CollisionShape2D.position.x = 2.66
				$DeathArea/CollisionShape2D.position.x = 2.66
		else:
			velocity.x = 0
			$AnimatedSprite.play("Idle")
		velocity.y += GRAVITY
		
		if get_slide_count() >= 0:
			for i in range (get_slide_count()):
				if "Player1" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.damage(10)
	
		velocity = move_and_slide(velocity, FLOOR)
		


func _on_Area2D_body_entered(body):
	if body != self:
		player = body;


func _on_Area2D_body_exited(body):
	player = null

func Damage(value):
	health -= value;
	if health > 0:
			get_node("./LifeCounter").text = str("HP: ", health, "%") 

	if health <= 0:
		$CollisionShape2D.disabled = true
		$DeathArea/CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		get_node("./LifeCounter").text = str("Dead") 
		Dead()
	
func _on_DeathArea_area_entered(area):
	if area.is_in_group("sword"):
		Damage(sword_Damage)
	elif area.is_in_group("arrow"):
		Dead()

func Dead():
	$CollisionShape2D.disabled = true
	$DeathArea/CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = true
	is_dead = true
	$AnimatedSprite.play("Death")
	

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Death":
		queue_free()
