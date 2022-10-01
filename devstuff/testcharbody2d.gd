extends CharacterBody2D


const SPEED = 300.0
const ACCEL_RATE = 0.2
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction:Vector2 = Vector2(0,0)
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	direction = direction.normalized()
	if direction.x:
		velocity.x = move_toward(velocity.x, direction.x*SPEED, SPEED*ACCEL_RATE)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED*ACCEL_RATE)
		
	if direction.y:
		velocity.y = move_toward(velocity.y, direction.y*SPEED, SPEED*ACCEL_RATE)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED*ACCEL_RATE)
	
	
	move_and_slide()
