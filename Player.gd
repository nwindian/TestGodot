extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
# The gravitational force applied to the character when in the air
@export var gravity = 9.8

@onready var camera = $Camera3D

var LOOKAROUND_SPEED = .1

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO

	#print(global_transform)
	if Input.is_action_pressed("move_right"):
		direction += global_transform.basis.x
	if Input.is_action_pressed("move_left"):
		direction -= global_transform.basis.x
	if Input.is_action_pressed("move_back"):
		direction += global_transform.basis.z
		#global_transform.basis.x[0]
	if Input.is_action_pressed("move_forward"):
		direction -= global_transform.basis.z
		
		#direction.x -= 1
		#direction.y += 1
		



	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Applying gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0 # Reset vertical velocity when on the floor

	## Moving the Character
	velocity.x = target_velocity.x * .7
	velocity.z = target_velocity.z * .7

	move_and_slide()

var rot_x = 0
var rot_y = 0
func _input(event):
	if event is InputEventMouseMotion:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rot_x += event.relative.x * .0015
			rot_y += event.relative.y * .0015
			if -rot_y > .6:
				rot_y = -.6
			elif -rot_y < -.5:
				rot_y = .5
			transform.basis = Basis() # reset rotation
			rotate_object_local(Vector3(0, 1, 0), -rot_x) # first rotate in Y
			rotate_object_local(Vector3(1, 0, 0), -rot_y) # then rotate in X
			
		



func _on_sketchfab_scene_child_entered_tree(node):
	print("true")
	pass # Replace with function body.


func _on_sketchfab_scene_tree_entered():
	print("true2")
	pass # Replace with function body.


func _on_visible_on_screen_enabler_3d_screen_entered():
	print("true3") # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_entered():
	print("true4")
	pass # Replace with function body.
