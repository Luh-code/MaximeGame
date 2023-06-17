extends CharacterBody2D

@export var debug_interface:Control

@export var camLerpSpeed:float = 0.4
@onready var camera:Camera2D = $Camera2D
@onready var lerpTarget:Node2D = $LerpTarget

@export var max_speed := 300.0
@export var accel := 700.0
@export var decel := 600.0

@export var holding_scene:PackedScene
@onready var hand:Node2D = $Hand

func _ready():
	change_weapon()

func change_weapon():
	var temp = holding_scene.instantiate()
	temp.name = "gun"
	hand.add_child(temp)

func _process(delta):
	#var dir = gun.get_angle_to( get_global_mouse_position() )
	#gun.rotation = dir
	hand.look_at(get_global_mouse_position())

func _physics_process(delta):
	var direction := Vector2(
		Input.get_axis("move_left", "move_right"), 
		Input.get_axis("move_up", "move_down")
	)
	
	if direction.x:
		velocity.x += direction.x * accel * delta
	else:
		velocity.x = move_toward(velocity.x, 0, decel * delta)
	
	if direction.y:
		velocity.y += direction.y * accel * delta
	else:
		velocity.y = move_toward(velocity.y, 0, decel * delta)
	
	if velocity.length_squared()>max_speed*max_speed:
		velocity=velocity.normalized()*max_speed
	
	debug_interface.update_velocity(velocity)
	
	var last_pos = lerpTarget.global_position
	move_and_slide()
	camera.global_position -= (lerpTarget.global_position - last_pos)/2
	
	camera.global_position = lerp(camera.global_position, lerpTarget.global_position, camLerpSpeed*delta)
	
	if Input.is_action_pressed("shoot"):
		hand.get_child(0).call("shoot")

