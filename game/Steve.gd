extends KinematicBody2D

var Velocity = Vector2(0,0)
export var SPEED = 0
export var GRAVITY = 0
export var JUMPFORCE = 0

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		Velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
		if Input.is_action_pressed("boost"):
			Velocity.x = SPEED * 3
			$Sprite.play("walk")
			$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		Velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
		if Input.is_action_pressed("boost"):
			Velocity.x = -SPEED * 3
			$Sprite.play("walk")
			$Sprite.flip_h = true
	else :
		$Sprite.play("idle")
	if not is_on_floor():
		$Sprite.play("air")
		
	Velocity.y += GRAVITY
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		Velocity.y = JUMPFORCE
	
	Velocity = move_and_slide(Velocity,Vector2.UP)
	Velocity.x = lerp(Velocity.x,0,0.2)
	
func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://restart screen.tscn")

func bounce():
	Velocity.y = JUMPFORCE * 0.7
	
func ouch(var enemyposx):
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	set_modulate(Color(1,0.3,0.3,0.3))
	Velocity.y = JUMPFORCE * 0.5
	$Timer.start(0.950)
	
	if position.x < enemyposx:
		Velocity.x = -800
	elif position.x > enemyposx:
		Velocity.x = 800
	else:
		Velocity.x = 0
		
func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
