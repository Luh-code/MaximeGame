extends Node2D

@onready var barrel: Node2D = $Barrel
@export var projectile: PackedScene
@onready var root = $"../../."
@export var shooting_speed: float = 15.0
@onready var cooldown_timer: Timer = $%Cooldown

func _ready():
	# set up timer
	
	cooldown_timer.wait_time = 1.0/shooting_speed
	cooldown_timer.one_shot = true
	

func _process(delta):
	# shoot if timer has run out and the shoot button is pressed 
	
	if cooldown_timer.time_left == 0 and Input.is_action_pressed("shoot"):
		# instantiate the projecile
		var temp: CharacterBody2D = projectile.instantiate()
		temp.global_position = barrel.global_position
		temp.global_rotation = self.global_rotation
		# set up collision for the projecile
		if root.is_in_group("Player"):
			temp.set_collision_mask_value(2, true)
		else:
			temp.set_collision_mask_value(1, true)
		# add projectile to scene tree
		get_tree().root.add_child(temp)
		cooldown_timer.start()

func _input(event):
	pass
