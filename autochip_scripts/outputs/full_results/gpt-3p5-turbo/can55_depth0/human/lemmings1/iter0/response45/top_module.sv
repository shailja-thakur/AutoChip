module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// State definition
	reg [1:0] state;
	parameter [1:0] WALK_LEFT = 2'b00;
	parameter [1:0] WALK_RIGHT = 2'b01;
	
	// Output definition
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	
	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			// State transitions based on inputs
			case (state)
				WALK_LEFT: begin
					if (bump_right)
						state <= WALK_RIGHT;
					end
				WALK_RIGHT: begin
					if (bump_left)
						state <= WALK_LEFT;
					end
				default: begin
					state <= WALK_LEFT;
				end
			endcase
		end
	end
endmodule
