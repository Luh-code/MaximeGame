extends CharacterBody2D

@onready var area: Area2D = $Area2D
@onready var hand: Node2D = $Hand
@onready var nava: NavigationAgent2D = $%NavigationAgent2D

var health: float = 100

@export var speed: float = 400.0
var movement_target_position: Vector2 = Vector2(60.0,180.0)

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	nava.path_desired_distance = 4.0
	nava.target_desired_distance = 4.0
	
	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func damage(dmg: float):
	health-=dmg
	if health <= 0:
		queue_free()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	
	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	nava.target_position = movement_target

func _physics_process(delta):
	if area.has_overlapping_bodies():
		var bodies = area.get_overlapping_bodies()
		for b in bodies:
			if b.is_in_group("Player"):
				var end_angle = hand.global_rotation+hand.get_angle_to(b.global_position)
				hand.global_rotation = lerp_angle(hand.global_rotation, end_angle, 0.3)
				hand.get_child(0).call("shoot")
				movement_target_position = get_tree().get_nodes_in_group("Player")[0].global_position
				actor_setup()
	
	if nava.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nava.get_next_path_position()
	
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * speed * delta
	
	velocity = new_velocity
	move_and_slide()
	#velocity = linear_velocity
	#move_and_slide()

