extends CharacterBody3D

@export var gravity = 40.0
@export var run_speed = 8.0
@export var jump_speed = 14.0
@export var acceleration = 40.0   
@export var friction = 20.0    
@export var jump_smoke_scene: PackedScene = preload("res://effects/JumpSmoke.tscn")

enum {IDLE, WALK, JUMP}
var state = IDLE

func _ready() -> void:
	floor_stop_on_slope = true
	floor_constant_speed = true
	# Giữ nhân vật bám sàn tốt hơn
	floor_snap_length = 0.2
	change_state(IDLE)

func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			$AnimatedSprite3D.play("idle")
		WALK:
			$AnimatedSprite3D.play("walk")
		JUMP:
			spawn_jump_smoke()
			$Jump.play()
			$AnimatedSprite3D.play("jump")

func _physics_process(delta):
	velocity.y -= gravity * delta
	get_input(delta)
	move_and_slide()
	update_state()

func get_input(delta):
	var right = Input.is_action_pressed("Right")
	var left = Input.is_action_pressed("Left")
	var jump = Input.is_action_just_pressed("Jump")
	
	var target_speed = 0
	if right:
		target_speed = run_speed
		$AnimatedSprite3D.flip_h = false
	elif left:
		target_speed = -run_speed
		$AnimatedSprite3D.flip_h = true

	if target_speed != 0:
		velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	print(velocity.x)
	if jump and is_on_floor():
		velocity.y = jump_speed
	

func update_state():
	if state == IDLE and velocity.x != 0:
		change_state(WALK)
	if state == WALK and velocity.x == 0:
		change_state(IDLE)
	if state in [IDLE, WALK] and !is_on_floor():
		change_state(JUMP)
	if state == JUMP and is_on_floor():
		change_state(IDLE)
		
func spawn_jump_smoke():
	var smoke = jump_smoke_scene.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
