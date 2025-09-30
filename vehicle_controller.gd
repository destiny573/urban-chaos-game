extends RigidBody2D

var engine_power = 500
var steering_power = 300
var is_player_inside = false
var player_reference = null

func _ready():
    InputManager.move_input.connect(_on_move_input)
    InputManager.interact_pressed.connect(_on_interact_pressed)

func _physics_process(delta):
    if is_player_inside:
        pass  # Physics handled by RigidBody

func _on_move_input(input_vector: Vector2):
    if is_player_inside:
        # Apply forces for vehicle movement
        var forward = -transform.x
        apply_central_force(forward * input_vector.y * engine_power)
        apply_torque(input_vector.x * steering_power)

func _on_interact_pressed():
    if is_player_inside and player_reference:
        player_reference.exit_vehicle()

func player_entered(player):
    is_player_inside = true
    player_reference = player
    GameManager.complete_mission()

func player_exited():
    is_player_inside = false
    player_reference = null
