extends KinematicBody2D

#variables
var speedY = 0
var velocity = Vector2(0,0)
var movementDirection = 1

#Constants
const SPEEDX = 150
const GRAVITY = 800

func _ready():
	set_process(true)
	pass

func _process(delta):
	speedY += GRAVITY * delta
	velocity.x = SPEEDX * delta * movementDirection
	velocity.y = speedY * delta
	var movementRemainder = move(velocity)
	if is_colliding():
		var normal = get_collision_normal()
		var object = get_collider()
		var objectParent = object.get_parent()		
		if(normal == Vector2(0,-1)):
			speedY = 0
		if(normal == Vector2(1,0)):
			movementDirection = 1
		elif( normal == Vector2(-1,0)):
			movementDirection = -1
		var finalMovement = normal.slide(movementRemainder)
		move(finalMovement)	
	pass
