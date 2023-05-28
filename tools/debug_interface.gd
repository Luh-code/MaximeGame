extends Control

@onready var fpsLabel := $TopLeft/FPS
@onready var velocityNameLabel := $TopLeft/Velocity/Name
@onready var velocityXLabel := $TopLeft/Velocity/X
@onready var velocityYLabel := $TopLeft/Velocity/Y

@onready var fps := 0
@onready var velocityX := 0
@onready var velocityY := 0

func update_fps(fps:float):
	fpsLabel.text = "FPS: " + str(snapped(fps, 0.01))

func _process(delta):
	update_fps(1/delta)

func update_velocity(velocity:Vector2):
	velocityXLabel.text = str(snapped(velocity.x, 0.01))
	velocityYLabel.text = str(snapped(velocity.y, 0.01))
