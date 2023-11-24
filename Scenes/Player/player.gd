extends CharacterBody2D

const MAX_SPEED = 200
const JUMP_VELOCITY = -400.0

@onready var sprite = $Sprite2D

var gravity = 980

func _physics_process(delta):
	#Animations
	if(velocity.x > 0 || velocity.x < 0):
		sprite.animation = "walking"
	else:
		sprite.animation = "default"
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction: 
		velocity.x = direction * MAX_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 30)
		
	move_and_slide()
	flip_sprite()
	
	
func flip_sprite():
	var isRight = velocity.x > 0
	var isLeft = velocity.x < 0
	if isRight:
		sprite.flip_h = true
	if isLeft:
		sprite.flip_h = false
