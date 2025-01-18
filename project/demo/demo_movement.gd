extends RigidBody3D

@export_category("Movement Values")

## Maximum achievable speed
@export_range(0.0, 5000.0, 10.0, "or_greater") var max_speed: float = 3000.0
## Scale to apply to 2D movement. X value handles left/right, Y value handles forwards/backwards
@export var force_scale: Vector2 = Vector2(1000.0, 1000.0)
## Yaw rotation rate
@export_range(0.0, 200.0, 1.0, "or_greater") var yaw_rate: float = 50.0
## Force of jump
@export_range(0.0, 1000.0, 1.0, "or_greater") var jump_force: float = 400.0
## Force of dash
@export_range(0.0, 5000.0, 1.0, "or_greater") var dash_force: float = 1000.0

@export_category("Control Settings")
@export var mouse_sensitivity: float = 0.001

@onready var twist_pivot = $TwistPivot
@onready var pitch_pivot = $TwistPivot/PitchPivot
var twist_input: float = 0.0
var pitch_input: float = 0.0

@onready var raycast = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# ToDo: Move this to a camera script
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-30),
		deg_to_rad(30)
	)
	twist_input = 0.0
	pitch_input = 0.0
	
	handle_2d_movement(Vector2(
		Input.get_axis("move_forward", "move_backwards"),
		Input.get_axis("move_left", "move_right")
	) * delta)
	
	handle_yaw_rotation(Input.get_axis("yaw_left", "yaw_right") * delta * -1)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("jump"):
		perform_jump()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = -1 * event.relative.x * mouse_sensitivity
			pitch_input = -1 * event.relative.y * mouse_sensitivity
			
## Process planar movement, make sure to multiply incoming value by the delta
func handle_2d_movement(value: Vector2) -> void:
	# Only perform movement if there's enough of a value and if the sled is on the ground
	if value.is_zero_approx() || !raycast.is_colliding():
		return
	
	var force: Vector3 = (basis.x * value.y * force_scale.y) + (basis.z * value.x * force_scale.x)
	apply_central_force(force)
	
## Process yaw rotation
func handle_yaw_rotation(value: float) -> void:
	if (is_zero_approx(value)):
		return
		
	apply_torque(Vector3(0, value * yaw_rate, 0))
	
func perform_jump() -> void:
	apply_impulse(Vector3(0, jump_force, 0))
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
