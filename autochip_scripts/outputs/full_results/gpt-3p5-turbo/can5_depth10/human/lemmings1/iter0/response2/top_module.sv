module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

reg [1:0] state;
// Define the states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		// Asynchronous reset, initialize to walk_left
		state <= WALK_LEFT;
	end else begin
		case(state)
			WALK_LEFT: begin
				if (bump_right) begin
					// If bumped on the right, switch to WALK_RIGHT
					state <= WALK_RIGHT;
				end else if (bump_left) begin
					// If bumped on the left, stay in WALK_LEFT
					state <= WALK_LEFT;
				end
			end
			
			WALK_RIGHT: begin
				if (bump_left) begin
					// If bumped on the left, switch to WALK_LEFT
					state <= WALK_LEFT;
				end else if (bump_right) begin
					// If bumped on the right, stay in WALK_RIGHT
					state <= WALK_RIGHT;
				end
			end
		endcase
	end
end

// Assign outputs based on current state
assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;

endmodule
