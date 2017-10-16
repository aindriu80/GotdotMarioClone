extends KinematicBody2D
#Variables
var speedX = 0
var speedY = 0
var velocity = Vector2(0,0)
var facingDirection = 0
var movementDirection = 0
#Constants
const MAXIMUMSPEED = 300
const MOVMULTI = 600
const JUMPFORCE = 350
const GRAVITY = 1000

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if(Input.is_action_pressed("move_jump")):
		speedY = -JUMPFORCE
	if(Input.is_action_pressed("move_left")):
		facingDirection = -1
	elif(Input.is_action_pressed("move_right")):
		facingDirection = 1
	else: facingDirection =0
	
	if(facingDirection!=0):
		speedX += MOVMULTI * delta
		movementDirection = facingDirection
	else: speedX -= MOVMULTI * 1.5 * delta
	speedX = clamp( speedX, 0, MAXIMUMSPEED)
	speedY += GRAVITY * delta
	velocity.x = speedX * delta * movementDirection
	velocity.y = speedY * delta
	var moveRemainder = move(velocity)
	if is_colliding():
		var normal = get_collision_normal()
		var finalMov = normal.slide(moveRemainder)
		speedY = 0
		move(finalMov)
	pass
