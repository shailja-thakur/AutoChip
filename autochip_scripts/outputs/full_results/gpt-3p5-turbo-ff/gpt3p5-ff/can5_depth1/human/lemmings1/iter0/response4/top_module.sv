module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

// Define the states
parameter LEFT = 2'b00;
parameter RIGHT = 2'b01;

reg [1:0] state;
reg walk_left, walk_right;

// Synchronous reset
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= LEFT;
	else
		state <= next_state;
end

// State transition and output logic
always @(state, bump_left, bump_right)
begin
	case (state)
		LEFT:
			begin
				// If bumped on the left, switch to the right state
				if (bump_left)
				begin
					walk_left <= 0;
					walk_right <= 1;
				end
				// If bumped on the right, switch to the left state
				else if (bump_right)
				begin
					walk_left <= 1;
					walk_right <= 0;
				end
				// If bumped on both sides or no bump, stay in the left state
				else
				begin
					walk_left <= 1;
					walk_right <= 0;
				end
			end
		RIGHT:
			begin
				// If bumped on the left, switch to the right state
				if (bump_left)
				begin
					walk_left <= 0;
					walk_right <= 1;
				end
				// If bumped on the right, switch to the left state
				else if (bump_right)
				begin
					walk_left <= 1;
					walk_right <= 0;
				end
				// If bumped on both sides or no bump, stay in the right state
				else
				begin
					walk_left <= 0;
					walk_right <= 1;
				end
			end
	endcase
end

endmodule
