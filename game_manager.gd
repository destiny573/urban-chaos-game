extends Node

var current_mission = "Find a vehicle"
var player_in_vehicle = false

func _ready():
    print("🚗 Urban Chaos - GTA Style Game Loaded!")
    print("Controls: Arrow Keys to move, E to enter/exit vehicle")

func show_prompt(text: String):
    print("Prompt: ", text)

func complete_mission():
    current_mission = "Drive to the checkpoint!"
    print("Mission Updated: ", current_mission)
