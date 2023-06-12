extends CharacterBody2D

@export var vel: Vector2 = Vector2.ZERO
@export var accel: Vector2 = Vector2.ZERO
@export var bounces: int = 0
@export var damage: float = 10.0

func _physics_process(delta):
	vel+=vel*accel*delta # geschwindigkeit verändern
	
	var collision: KinematicCollision2D = move_and_collide(vel.rotated(self.global_rotation) * delta) # bewegen
	if collision:
		if collision.get_collider().is_class("CharacterBody2D") and collision.get_collider().is_in_group("Enemy"):
			collision.get_collider().call("damage", damage)
		
		if bounces > 0:
			handle_collision(collision) # bounce
			bounces-=1
		else:
			despawn() # sich löschen
	
	#for index in range(get_slide_collision_count()):
	#	var collision = get_slide_collision(index)
	#	if true: #collision.get_collider().is_in_group("Projectile"):
	#		health -= 10
	#		print("hit")
	#		if health <= 0:
	#			self.queue_free()

func handle_collision(collision : KinematicCollision2D):
	vel = vel.bounce(collision.get_normal())

func despawn():
	self.queue_free()
