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
	get_input()
	var was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor && !is_on_floor():
		$CoyoteTimer.start()
	update_state()

func get_input():
	var input_direction = Input.get_axis("Left", "Right")
	var jump = Input.is_action_just_pressed("Jump")
	
	velocity.z = 0
	
	if input_direction != 0:
		velocity.x = move_toward(velocity.x, input_direction * run_speed, acceleration * get_physics_process_delta_time())
		if input_direction > 0:
			$AnimatedSprite3D.flip_h = false
		elif input_direction < 0:
			$AnimatedSprite3D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, friction * get_physics_process_delta_time())
	
	if jump and (is_on_floor() or !$CoyoteTimer.is_stopped()):
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
