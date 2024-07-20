module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

reg [1:0] state;
reg walk_left;
reg walk_right;

// Define states
parameter walking_left = 2'b00;
parameter walking_right = 2'b01;

// Define initial state
initial
	state = walking_left;

// State machine process
always @(posedge clk or posedge areset)
	if (areset)
		state <= walking_left;
	else
		case (state)
			walking_left: begin
				if (bump_left)
					state <= walking_right;
			end
			walking_right: begin
				if (bump_right)
					state <= walking_left;
			end
		endcase

// Output generation
always @*
	case (state)
		walking_left: begin
			walk_left = 1;
			walk_right = 0;
		end
		walking_right: begin
			walk_left = 0;
			walk_right = 1;
		end
	endcase

endmodule
