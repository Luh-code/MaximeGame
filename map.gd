extends Node2D

@onready var roomsNode = $%rooms

@export var starting: PackedScene
@export var rooms: Array[PackedScene]
@export var roomnum: int

func _ready():
	var start = starting.instantiate()
	roomsNode.add_child(start)
	
	var doors = [
		start.get_node("doorbottom"),
		start.get_node("doortop"),
		start.get_node("doorright"),
		start.get_node("doorleft")
	]
	var base: int = 0
	var baseset: bool = false;
	for i in range(roomnum):
		if not baseset:
			base = i
			baseset = true
		var room: PackedScene = rooms[randi()%rooms.size()]
		var temp = room.instantiate()
		var doors2 = [
			temp.get_node("doorbottom"),
			temp.get_node("doortop"),
			temp.get_node("doorright"),
			temp.get_node("doorleft")
		]
		var pos: int = i%4
		temp.position += start.position
		temp.position += doors[pos].position
		temp.position += doors2[pos].position
		roomsNode.add_child(temp)
		
		if pos == 3:
			start = temp
			doors = doors2
			baseset = false
