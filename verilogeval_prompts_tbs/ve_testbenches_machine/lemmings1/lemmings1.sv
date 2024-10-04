//  This top Verilog module is a state machine that controls the walking direction of a robot. The module has 6 ports: clk, areset, bump_left, bump_right, walk_left, and walk_right. The clk port is an input port that is used to synchronize the state machine. The areset port is an input port that is used to reset the state machine to the initial state. The bump_left and bump_right ports are input ports that indicate whether the robot has bumped into an obstacle on the left or right side. The walk_left and walk_right ports are output ports that indicate the walking direction of the robot.  The module has two parameters, WL and WR, which represent the two states of the state machine. The state machine is implemented using a register, state, and a combinational logic block. The combinational logic block is used to determine the next state of the state machine based on the current state and the bump_left and bump_right inputs. If the current state is WL, the next state will be WR if the bump_left input is high, and WL if the bump_left input is low. Similarly, if the current state is WR, the next state will be WL if the bump_right input is high, and WR if the bump_right input is low.  The state machine is updated on the rising edge of the clk signal, and is reset to the initial state (WL) on the rising edge of the areset signal. The walk_left and walk_right outputs are assigned based on the current state of the state machine. If the state is WL, the walk_left output will be high and the walk_right output will be low. If the state is WR, the walk_left output will be low and the walk_right output will be high.

module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
