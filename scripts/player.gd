extends CharacterBody2D

const movementSpeed = 100
var currentDirection = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")
	pass
	
func _physics_process(delta):
	player_movement(delta)
	
# if round(player.x) % tileSize == 44:
#            if not keys[pygame.K_LEFT] and not keys[pygame.K_a] and not keys[pygame.K_RIGHT] and not keys[pygame.K_d] and not keys[pygame.K_UP] and not keys[pygame.K_w] and not keys[pygame.K_DOWN] and not keys[pygame.K_s]:
#                player.speedX = 0
#            player.originalPlace()
#        if round(player.y) % tileSize == 21:
#           if not keys[pygame.K_LEFT] and not keys[pygame.K_a] and not keys[pygame.K_RIGHT] and not keys[pygame.K_d] and not keys[pygame.K_UP] and not keys[pygame.K_w] and not keys[pygame.K_DOWN] and not keys[pygame.K_s]:
#               player.speedY = 0
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		currentDirection = "right"		
		play_anim(1)
		velocity.x = movementSpeed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		play_anim(1)		
		currentDirection = "left"		
		velocity.x = -movementSpeed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		play_anim(1)		
		currentDirection = "down"		
		velocity.x = 0
		velocity.y = movementSpeed		
	elif Input.is_action_pressed("ui_up"):
		play_anim(1)		
		currentDirection = "up"		
		velocity.x = 0
		velocity.y = -movementSpeed	
	else:
		if int(position.x) % 16 == 0:
			velocity.x = 0
		if int(position.y) % 16 == 7 or int(position.y) % 16 == -7:
			velocity.y = 0
		if int(position.x) % 16==0 and (int(position.y) % 16 == 7 or int(position.y) % 16 == -7):
			play_anim(0)	
	print(int(position.y) % 16)
	print("x: %d y: %d" % [position.x, position.y])	
	move_and_slide()

func play_anim(movement):
	var dir = currentDirection
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")	
	if dir == "up":
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")	
			
	if dir == "down":
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")	
	

func _on_player_hitbox_area_entered(area):
	if area.name == "EnemyHitbox":
		get_tree().change_scene_to_file("res://scenes/battle.tscn")
			#make it so it changes to battle scene and stores original place
	if area.name == "NPCHitbox":
		var interactedWithPlayer = true
		pass #run command to make dialogue
			
	print_debug(area.get_parent().name)
