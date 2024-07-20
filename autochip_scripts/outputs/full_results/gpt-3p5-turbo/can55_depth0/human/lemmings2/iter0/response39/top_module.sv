module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left = 1,
	output reg walk_right = 0,
	output reg aaah = 0
);

	// State declaration
	reg [1:0] state;

	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;
		else begin
			case (state)
				
				// Walking left state
				2'b00: begin
					if (bump_right)
						state <= 2'b01;
				end
				
				// Walking right state
				2'b01: begin
					if (bump_left)
						state <= 2'b00;
				end
				
				// Falling state
				2'b10: begin
					if (ground)
						state <= walk_left ? 2'b00 : 2'b01;
				end
			endcase
		end
	end

	// Output logic
	always @* begin
		case (state)
			2'b00: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
			2'b01: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end
			2'b10: begin
				walk_left = walk_left;
				walk_right = walk_right;
				aaah = 1;
			end
		endcase
	end
    
endmodule
