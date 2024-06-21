extends CharacterBody2D

var currentHealth = 25
var maxHealth = 25
var attackSpeed = 25
var defence =  3
var attack = 15

var speed = 75
var playerInZone = false
var player = null

func _on_enemy_hitbox_area_entered(area):
	print_debug(area.get_parent().name) # Replace with function body.

func removeEnemy():
	queue_free()

func _physics_process(delta):
	if playerInZone:
		position += (player.position - position)/speed
		
		
		
func _on_detection_box_body_entered(body):
	player = body
	playerInZone = true

func _on_detection_box_body_exited(body):
	player = null
	playerInZone = false
