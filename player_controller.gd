extends CharacterBody2D

var speed = 200
var is_in_vehicle = false
var nearby_vehicle = null

func _ready():
    InputManager.move_input.connect(_on_move_input)
    InputManager.interact_pressed.connect(_on_interact_pressed)

func _physics_process(delta):
    if not is_in_vehicle:
        move_and_slide()
        _check_nearby_vehicle()

func _on_move_input(input_vector: Vector2):
    if is_in_vehicle:
        return
        
    velocity = input_vector * speed

func _on_interact_pressed():
    if is_in_vehicle:
        exit_vehicle()
    elif nearby_vehicle:
        enter_vehicle(nearby_vehicle)

func _check_nearby_vehicle():
    var space_state = get_world_2d().direct_space_state
    var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(100, 0))
    var result = space_state.intersect_ray(query)
    
    if result:
        var collider = result.collider
        if collider and collider.has_method("player_entered"):
            nearby_vehicle = collider
            GameManager.show_prompt("Press E to Enter Vehicle")

func enter_vehicle(vehicle):
    is_in_vehicle = true
    nearby_vehicle = vehicle
    vehicle.player_entered(self)
    visible = false
    collision_layer = 0

func exit_vehicle():
    if nearby_vehicle:
        nearby_vehicle.player_exited()
        global_position = nearby_vehicle.global_position + Vector2(50, 0)
        visible = true
        collision_layer = 1
        is_in_vehicle = false
        nearby_vehicle = null
