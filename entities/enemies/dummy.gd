extends CharacterBody2D

var health: float = 100

func damage(dmg: float):
	health-=dmg
	if health <= 0:
		queue_free()

func _physics_process(delta):
	pass
