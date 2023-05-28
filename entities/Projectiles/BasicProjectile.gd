extends CharacterBody2D

@export var vel: Vector2 = Vector2.ZERO
@export var accel: Vector2 = Vector2.ZERO
@export var bounces: int = 0

func _physics_process(delta):
	vel+=vel*accel*delta # geschwindigkeit verändern
	
	var collision: KinematicCollision2D = move_and_collide(vel.rotated(self.global_rotation) * delta) # bewegen
	if collision:
		if bounces > 0:
			handle_collision(collision) # bounce
			bounces-=1
		else:
			despawn() # sich löschen

func handle_collision(collision : KinematicCollision2D):
	vel = vel.bounce(collision.get_normal())

func despawn():
	self.queue_free()
