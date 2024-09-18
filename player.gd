extends CharacterBody2D

@export var move_speed : float = 100
@export var start_direction : Vector2 = Vector2(0, 1)

@onready var anim_tree = $AnimationTree
@onready var state_machine = anim_tree.get("parameters/playback")

var speed = 200
var mode = Mode.TOP_DOWN 

enum Mode { TOP_DOWN, SIDE_SCROLL }

func _ready():
	anim_tree.set("parameters/Idle/blend_position", start_direction)
	
func _physics_process(_delta):
	
	var input_direction = Vector2()
	
	if mode == Mode.TOP_DOWN:
		input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		velocity = input_direction * move_speed
		
	
	elif mode == Mode.SIDE_SCROLL:
		input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			0
		)
		velocity.x = input_direction.x * move_speed
		if Input.is_action_just_pressed("jump") and is_on_floor:
			velocity.y = -speed 
			
	move_and_slide()
	update_anim_parm(input_direction)
	pick_new_state()
	
func update_anim_parm(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		anim_tree.set("parameters/Run/blend_position", move_input)
		anim_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")

func set_mode(new_mode):
	mode = new_mode
