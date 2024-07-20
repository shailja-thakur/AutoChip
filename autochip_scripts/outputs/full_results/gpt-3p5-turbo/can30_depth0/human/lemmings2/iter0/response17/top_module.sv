module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

	// Define states
	parameter WAITING = 2'b00;
	parameter WALK_LEFT = 2'b01;
	parameter WALK_RIGHT = 2'b10;
	
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Initialize state register and output signals on reset
	always @(posedge clk or posedge areset)
	begin
		if (areset)
		begin
			state <= WAITING;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
		end
		else
		begin
			state <= next_state;
			walk_left <= (state == WALK_LEFT);
			walk_right <= (state == WALK_RIGHT);
			aaah <= 0;
		end
	end
	
	// Define next state logic
	always @(*)
	begin
		case(state)
			WAITING:
				begin
					if (bump_left)
						next_state = WALK_RIGHT;
					else if (bump_right)
						next_state = WALK_LEFT;
					else if (ground == 0)
						next_state = WAITING;
					else
						next_state = state;
				end
			WALK_LEFT:
				begin
					if (bump_left && bump_right)
						next_state = WALK_RIGHT;
					else if (bump_right)
						next_state = WALK_LEFT;
					else if (ground == 0)
						next_state = WAITING;
					else
						next_state = state;
				end
			WALK_RIGHT:
				begin
					if (bump_left && bump_right)
						next_state = WALK_LEFT;
					else if (bump_left)
						next_state = WALK_RIGHT;
					else if (ground == 0)
						next_state = WAITING;
					else
						next_state = state;
				end
			default: next_state = WAITING;
		endcase
	end
	
endmodule
