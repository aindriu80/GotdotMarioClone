extends KinematicBody2D

#variables
var speedY = 0
var velocity = Vector2(0,0)
var movementDirection = -1
var deltaTime = 0

#Constants
const SPEEDX = 150
const GRAVITY = 800


func _animate():
	if(get_node("Sprite").get_frame()>=3):
		get_node("Sprite").set_frame(0)
	if(get_node("Sprite").get_frame()<3):
		get_node("Sprite").set_frame(get_node("Sprite").get_frame()+1)
	deltaTime = 0
	pass

func _ready():
	set_process(true)
	pass

func _process(delta):
	if(get_node("CollisionShape2D").is_trigger()):
		get_node("Sprite").set_frame(4)
	deltaTime = deltaTime + delta
	if(deltaTime > 0.1):
		_animate()
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
			get_node("Sprite").set_flip_h(true)
		elif( normal == Vector2(-1,0)):
			movementDirection = -1
			get_node("Sprite").set_flip_h(false)
		var finalMovement = normal.slide(movementRemainder)
		move(finalMovement)	
	pass
