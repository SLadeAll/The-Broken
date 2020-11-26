extends KinematicBody2D

func _ready():
	pass # Replace with function body.

signal health_update(health)
signal killed()

var Results
var On_Damage = false;
var isAttacking = false;
var velocity = Vector2();
var on_ground = false;
var SPEED = 250;
const GRAVITY = 15
const JUMP_POWER = -450
const FLOOR = Vector2(0, -1)
#const ARROW = preload("res://Arrow.tscn")
const ARROW = preload("res://FireBall.tscn")
export (float) var max_health = 150;
var is_dead = false

onready var health = max_health 

onready var invulnerabilityTimer = $FreeFrames

func _physics_process(delta):
	if is_dead == false:
		if Input.is_action_pressed("ui_right") && isAttacking == false:
			velocity.x = SPEED
			if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
			if on_ground == true  && On_Damage == false:
				$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = false
			$AttackArea/CollisionShape2D.position.x = -2.306
			
		elif Input.is_action_pressed("ui_left")  && isAttacking == false:
			velocity.x = -SPEED
			if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
			if on_ground == true && On_Damage == false:
				$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = true
			$AttackArea/CollisionShape2D.position.x = -56.3
		else:
			velocity.x = 0;
			if isAttacking == false && on_ground == true && On_Damage == false:
				$AnimatedSprite.play("Idle")
				
		if Input.is_action_pressed("ui_up") && isAttacking == false:
			if  On_Damage == false:
				$AnimatedSprite.play("Jump")
			if on_ground == true:
				velocity.y = JUMP_POWER
				on_ground = false
		velocity.y += GRAVITY;
		get_node("./LifeCounter").text = str("HP: ", health, "%") 

		if Input.is_action_just_pressed("Attack") && on_ground == true:
			isAttacking = true
			$AnimatedSprite.play("Attack");
			$AttackArea/CollisionShape2D.disabled = false
		if Input.is_action_just_pressed("BowAttack") && on_ground == true:
			isAttacking = true
			$AnimatedSprite.play("Bow")
			var fireball = ARROW.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_arrow_direction(1)
			else:
				fireball.set_arrow_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			
		if is_on_floor():
			on_ground = true;
		else:
			on_ground = false
		velocity = move_and_slide(velocity, FLOOR)
		
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "KnightEnemy" in get_slide_collision(i).collider.name:
					On_Damage = true
					damage(10)
				elif "WolfEnemy" in get_slide_collision(i).collider.name:
					On_Damage = true
					damage(20)
				elif "HellHoundEnemy" in get_slide_collision(i).collider.name:
					On_Damage = true
					damage(30)
				elif "InstantDead" in get_slide_collision(i).collider.name:
					On_Damage = true
					damage(500)
				elif "KnightEnemyTutorial" in get_slide_collision(i).collider.name:
					On_Damage = false
					damage(0)
				elif "LargeEnemy" in get_slide_collision(i).collider.name:
					On_Damage = false
					damage(20)

func damage(value):
	if invulnerabilityTimer.is_stopped():
		invulnerabilityTimer.start()
		$AnimatedSprite.play("Hurt")
		health = health - value;
		if health > 0:
			get_node("./LifeCounter").text = str("HP: ", health, "%") 
		
	if health <= 0:
		kill()
		get_node("./LifeCounter").text = str("Dead") 

func kill():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("Dead")
	$CollisionShape2D.disabled = true
	$Timer.start() 

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attack":
		$AttackArea/CollisionShape2D.disabled = true;
		isAttacking = false
	if $AnimatedSprite.animation == "Bow":
		$AttackArea/CollisionShape2D.disabled = true;
		isAttacking = false
		


func _on_Timer_timeout():
	
	var currentScene = get_tree().current_scene.filename
	get_tree().change_scene(currentScene)


func _on_FreeFrames_timeout():
	On_Damage = false
