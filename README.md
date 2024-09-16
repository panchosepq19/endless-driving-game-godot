# 3D Car Simulation in Godot
This project is a 3D car simulation built in Godot, where you can drive a car on a plane with realistic controls, including steering, acceleration, braking, and lighting effects. The car is controlled using a CharacterBody3D node, with customizable parameters for speed, acceleration, friction, and more.

## Features

1. **Realistic Car Movement:** The car can accelerate, decelerate, and reverse with smooth transitions.
  
2. **Steering Mechanics:** Control the car's direction with adjustable tire angles.

3. **Tire Rotation:** The tires spin based on the car's speed, including reverse direction.

4. **Brake Lights:** The brake lights activate when the car decelerates, enhancing realism.
   
5. **Headlights:** Toggle the headlights on and off, simulating night driving.
   
6. **Gravity Handling:** The car responds to gravity, allowing for potential future expansions like ramps or hills.

## Controls

W: Move Forward

S: Move Backward (Reverse when the car is stationary)

A: Turn Left

D: Turn Right

Space: Brake

H: Toggle Headlights

## Installation

### Clone this repository to your local machine:

git clone https://github.com/panchosepq19/endless-driving-game-godot.git

Open the project in Godot.

Run the scene to start the simulation.

## Customization

You can easily tweak various parameters to customize the car's behavior:

MAX_SPEED: Maximum speed the car can reach.

ACCELERATION: Rate of acceleration.

FRICTION: Deceleration when not accelerating.

BRAKE_FORCE: Deceleration when braking.

TURN_SPEED: Speed at which the car turns.

TIRE_ACCELERATION: Rate at which the tire angle changes when turning.

TIRE_RETURN_SPEED: Speed at which the tires return to the straight position after turning.

## Future Work

Terrain Features: Add ramps, hills, and other terrain elements to enhance the driving experience.

Advanced Physics: Implement more realistic car physics with suspension, drift mechanics, and collisions.

AI Opponents: Introduce AI-controlled cars to create a racing environment.

Multiplayer Mode: Allow multiple players to drive cars in the same scene.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
