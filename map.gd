extends Node2D

@onready var roomsNode = $%rooms

@export var starting: PackedScene
@export var rooms: Array[PackedScene]
@export var roomnum: int

func _ready():
	var start = starting.instantiate()
	roomsNode.add_child(start)
	
	var topDoors = [
		start.get_node("doortop")
	]
	var bottomDoors = [
		start.get_node("doorbottom")
	]
	var leftDoors = [
		start.get_node("doorleft")
	]
	var rightDoors = [
		start.get_node("doorright")
	]
	
	var allDoors = [
		topDoors,
		bottomDoors,
		leftDoors,
		rightDoors
	]
	
	for i in range(roomnum):
		var room: PackedScene = rooms[randi()%rooms.size()]
		var temp = room.instantiate()
		
		var doors = [
			temp.get_node("doorbottom"),
			temp.get_node("doortop"),
			temp.get_node("doorright"),
			temp.get_node("doorleft")
		]
		
		var door: Node2D
		var connected_door
		match randi_range(2, 2):
			0:
				if topDoors.size() == 0:
					i -= 1
					continue
				var index = randi_range(0, topDoors.size()-1)
				door = topDoors[index]
				topDoors.remove_at(index)
				connected_door = doors[0]
				topDoors.append(doors[1])
				rightDoors.append(doors[2])
				leftDoors.append(doors[3])
				doors.remove_at(0)
			1:
				if bottomDoors.size() == 0:
					i -= 1
					continue
				var index = randi_range(0, bottomDoors.size()-1)
				door = bottomDoors[index]
				bottomDoors.remove_at(index)
				connected_door = doors[1]
				bottomDoors.append(doors[0])
				rightDoors.append(doors[2])
				leftDoors.append(doors[3])
				doors.remove_at(1)
			2:
				if leftDoors.size() == 0:
					i -= 1
					continue
				var index = randi_range(0, leftDoors.size()-1)
				door = leftDoors[index]
				leftDoors.remove_at(index)
				connected_door = doors[2]
				bottomDoors.append(doors[0])
				topDoors.append(doors[1])
				leftDoors.append(doors[3])
				doors.remove_at(2)
			3:
				if rightDoors.size() == 0:
					i -= 1
					continue
				var index = randi_range(0, rightDoors.size()-1)
				door = rightDoors[index]
				rightDoors.remove_at(index)
				connected_door = doors[3]
				bottomDoors.append(doors[0])
				topDoors.append(doors[1])
				rightDoors.append(doors[2])
				doors.remove_at(3)
		
		temp.position = start.position
		temp.position += door.global_position
		temp.position -= connected_door.position
		roomsNode.add_child(temp)
