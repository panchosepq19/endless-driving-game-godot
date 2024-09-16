extends CharacterBody3D

# Constants
const MAX_SPEED = 20.0  
const ACCELERATION = 5.0  
const FRICTION = 5.0  # Deceleration 
const BACKWARD_FRICTION = 1.0
const BRAKE_FORCE = 10.0  # Deceleration when braking
const TURN_SPEED = 2.0  
const GRAVITY = -9.8
const TIRE_ACCELERATION = 30.0  # For steering angle not for tire spin
const TIRE_RETURN_SPEED = 50.0  # Speed at which tires return to straight position

# Variables
var current_speed = 0.0  # Current speed of the car
var tire_angle = 0.0  # Current steering angle of tires
var tire_spin_speed = 0.0  # Current spin speed of tires
var headlights_on = false 
var can_toggle_headlights = true

@export var tire_left_back: Node
@export var tire_right_back: Node
@export var tire_left_front: Node
@export var tire_right_front: Node

@export var brake_light_left: MeshInstance3D
@export var brake_light_right: MeshInstance3D
@export var brake_light_material_on: StandardMaterial3D
@export var brake_light_material_off: StandardMaterial3D

@export var headlight_right: MeshInstance3D
@export var headlight_left: MeshInstance3D
@export var headlight_material_on: StandardMaterial3D
@export var headlight_material_off: StandardMaterial3D


func _physics_process(delta: float) -> void:

	# Handle gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Determine direction and apply acceleration/deceleration
	if Input.is_action_pressed("move_forward"):
		current_speed += ACCELERATION * delta
	elif Input.is_action_pressed("move_backward") and current_speed <= 0:
		# Allow reversing only when the car is not moving forward
		current_speed -= ACCELERATION * delta # Accelerate in reverse
	elif Input.is_action_pressed("brake"):
		if current_speed > 0:
			current_speed -= BRAKE_FORCE * delta
			current_speed = max(current_speed, 0)  # Prevent going negative, stop at 0
			brake_light_left.material_override = brake_light_material_on
			brake_light_right.material_override = brake_light_material_on
	else:
		brake_light_left.material_override = brake_light_material_off
		brake_light_right.material_override = brake_light_material_off
		if current_speed > 0:
			current_speed -= FRICTION * delta  # Decelerate if moving forward
			current_speed = max(current_speed, 0)  # Ensure speed doesn't go below 0
		elif current_speed < 0:
			current_speed += FRICTION * delta  # Decelerate if moving backward
			current_speed = min(current_speed, 0)  # Ensure speed doesn't go above 0
		
		
	# Toggle headlights
	if Input.is_action_pressed("head_lights") and can_toggle_headlights:
		if headlights_on:
			headlight_left.material_override = headlight_material_off
			headlight_right.material_override = headlight_material_off
			headlights_on = false
		else:
			headlight_left.material_override = headlight_material_on
			headlight_right.material_override = headlight_material_on
			headlights_on = true
			
		can_toggle_headlights = false
	
	if Input.is_action_just_released("head_lights"):
		can_toggle_headlights = true
	
	# Clamp speed
	current_speed = clamp(current_speed, -MAX_SPEED * 0.1, MAX_SPEED)

	# Calculate tire spin speed based on car's speed and direction
	tire_spin_speed = current_speed * 10.0  # Adjust tire spin for reverse

	# Rotate all tires based on spin speed
	tire_left_back.rotation_degrees.x -= tire_spin_speed * delta
	tire_right_back.rotation_degrees.x -= tire_spin_speed * delta
	tire_left_front.rotation_degrees.x -= tire_spin_speed * delta
	tire_right_front.rotation_degrees.x -= tire_spin_speed * delta

	# Steering and tire angle adjustment
	if current_speed != 0:
		if Input.is_action_pressed("turn_left"):
			rotation.y += TURN_SPEED * delta 
			tire_angle += TIRE_ACCELERATION * delta
		elif Input.is_action_pressed("turn_right"):
			rotation.y -= TURN_SPEED * delta  
			tire_angle -= TIRE_ACCELERATION * delta
		else:
			# Gradually return tires to straight position when not turning
			if tire_angle > 0:
				tire_angle -= TIRE_RETURN_SPEED * delta
				tire_angle = max(tire_angle, 0)
			elif tire_angle < 0:
				tire_angle += TIRE_RETURN_SPEED * delta
				tire_angle = min(tire_angle, 0)

		# Clamp tire steering rotation to prevent excessive rotation
		tire_angle = clamp(tire_angle, -45, 45)

		# Apply the steering angle to the front tires
		tire_left_front.rotation_degrees.y = tire_angle
		tire_right_front.rotation_degrees.y = tire_angle
	
	if current_speed != 0:
		var forward_dir = -transform.basis.z.normalized()
		velocity.x = forward_dir.x * current_speed
		velocity.z = forward_dir.z * current_speed
	
	move_and_slide()
	
	
