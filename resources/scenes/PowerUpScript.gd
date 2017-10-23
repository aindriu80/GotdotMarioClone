extends KinematicBody2D

#variables
var speedY = 0
var velocity = Vector2(0,0)
var movementDirection = 1

#Constants
const SPEEDX = 200
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
		if( normal == Vector2(1,0) or normal == Vector2(-1,0)):
			movementDirection = movementDirection * -1
		var finalMovement = normal.slide(movementRemainder)
		move(finalMovement)	
	pass
