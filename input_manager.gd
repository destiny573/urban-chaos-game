extends Node

signal move_input(vector2)
signal interact_pressed()

var left_stick_vector := Vector2.ZERO

func _ready():
    pass

func _process(_delta):
    emit_signal("move_input", left_stick_vector)
    
    # Keyboard controls
    var keyboard_vector := Vector2.ZERO
    if Input.is_action_pressed("ui_up"):
        keyboard_vector.y -= 1
    if Input.is_action_pressed("ui_down"):
        keyboard_vector.y += 1
    if Input.is_action_pressed("ui_left"):
        keyboard_vector.x -= 1
    if Input.is_action_pressed("ui_right"):
        keyboard_vector.x += 1
    
    if keyboard_vector.length() > 0:
        emit_signal("move_input", keyboard_vector.normalized())
    
    if Input.is_action_just_pressed("interact"):
        interact_pressed.emit()

func update_left_stick(vector: Vector2):
    left_stick_vector = vector
