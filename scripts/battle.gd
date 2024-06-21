extends Control
#make sure sweetheart attacks are shown 
# Called when the node enters the scene tree for the first time.
var changeScene = false
var enemyTurn = false
var playerDead = false
var startingPlayerStats = [PlayerStats.defence, PlayerStats.attack]
var startingEnemyStats = [Enemy.defence, Enemy.attack]
func _ready():
	$TextureRect/EnemyBattleChar/Enemy.play("default")
	setHealth($ActionPanel/HealthBar, PlayerStats.currentHealth, PlayerStats.maxHealth)
	setHealth($HealthBar, Enemy.currentHealth, Enemy.maxHealth)
	displayText("Welcome to your first battle player. What would you like to do?")
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if Input.is_action_just_pressed("ui_accept") and $ActionPanel/PlayerAction.visible:
		$ActionPanel/Attack.show()
		$ActionPanel/Strengthen.show()
		$ActionPanel/Defend.show()
		$ActionPanel/Heal.show()
		$ActionPanel/PlayerAction.hide()
		$TextureRect/EnemyBattleChar/Enemy.play("default")
		if changeScene == true:
				PlayerStats.defence = startingPlayerStats[0]
				PlayerStats.attack = startingPlayerStats[1]
				Enemy.defence = startingEnemyStats[0]
				Enemy.attack = startingEnemyStats[1]
				Enemy.currentHealth = Enemy.maxHealth
				if PlayerStats.currentHealth == 0:
					PlayerStats.currentHealth = PlayerStats.maxHealth
				get_tree().change_scene_to_file("res://scenes/main.tscn")	
				#Enemy.removeEnemy()
		if enemyTurn == true:
			if Enemy.currentHealth == 0:
				displayText("\"No... I can't die just yet...\"")
				$TextureRect/EnemyBattleChar/Enemy.play("dead")
				changeScene = true
			else:
				enemy_turn()	
		else:
			if PlayerStats.currentHealth == 0:
				displayText("\"Muahahaha... I told you not to challenge me!\"")
				changeScene = true

		
func displayText(text):
	$ActionPanel/Attack.hide()
	$ActionPanel/Strengthen.hide()
	$ActionPanel/Defend.hide()
	$ActionPanel/Heal.hide()
	$ActionPanel/PlayerAction.show()
	$ActionPanel/PlayerAction.text = text


func displayEnemyText(text):
	$EnemyMovePanel/EnemyActionLabel.text = text
	
func setHealth(progress_bar, currentHealth, maxHealth):
	progress_bar.value = currentHealth
	progress_bar.max_value = maxHealth
	progress_bar.get_node("Label").text = "Health: %d/%d" % [currentHealth, maxHealth]

func _on_attack_pressed():
	var randomAttk = randi_range(PlayerStats.attack-2,PlayerStats.attack+2)	
	Enemy.currentHealth = max(0, Enemy.currentHealth - randomAttk/Enemy.defence)
	setHealth($HealthBar, Enemy.currentHealth, Enemy.maxHealth)
	displayText("You dealt %d damage" % (randomAttk/Enemy.defence))
	$TextureRect/EnemyBattleChar/Enemy.play("hurt")
	enemyTurn = true
	
func _on_heal_pressed():
	var randomHeal = randi_range(1,6)
	displayText("You healed %d health" % randomHeal)
	PlayerStats.currentHealth = min(50, PlayerStats.currentHealth + randomHeal)
	setHealth($ActionPanel/HealthBar, PlayerStats.currentHealth, PlayerStats.maxHealth)
	enemyTurn = true

func _on_defend_pressed():
	var randDefence = randi_range(1,4)	
	displayText("Your defence went up by %d" % randDefence)	
	PlayerStats.defence += randDefence
	enemyTurn = true


func _on_strengthen_pressed():
	var randAttack = randi_range(1,4)	
	displayText("Your attack went up by %d" % randAttack)	
	PlayerStats.attack += randAttack
	enemyTurn = true
	
func enemy_turn():
	var action = randi_range(0,2)
	if action == 0:
		displayText("Sweetheart swings her mace, dealing %d damage" % (Enemy.attack/PlayerStats.defence))
		PlayerStats.currentHealth = max(0, PlayerStats.currentHealth - Enemy.attack/PlayerStats.defence)
		setHealth($ActionPanel/HealthBar, PlayerStats.currentHealth, PlayerStats.maxHealth)
		$AnimationPlayer.play("playerHurt")
	if action == 1:
		displayText("Sweetheart laughs at you, bringing her attack up")
		var randAttack = randi_range(2,6)	
		Enemy.attack += randAttack
	if action == 2:
		displayText("Sweetheart laughs at you, bringing her defence up")
		var randDefence = randi_range(2,6)	
		Enemy.defence += randDefence
	enemyTurn = false
		
	
