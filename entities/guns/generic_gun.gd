extends Node2D

@onready var barrel: Node2D = $Barrel
@export var projectile: PackedScene
@onready var root = $"../../."
@export var shooting_speed: float = 5.0
@onready var cooldown_timer: Timer = $%Cooldown

func _ready():
	# set up timer
	
	cooldown_timer.wait_time = 1.0/shooting_speed
	cooldown_timer.one_shot = true
	

func shoot():
	if cooldown_timer.time_left == 0:
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

func _process(delta):
	pass

func _input(event):
	pass
