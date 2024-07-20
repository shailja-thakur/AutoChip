module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Internal signals
	reg [1:0] state;
	reg walk_left_int;
	reg walk_right_int;
	
	// State definitions
	parameter LEFT = 2'b00;
	parameter RIGHT = 2'b01;
	
	// Register assignments
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT;
		else begin
			case (state)
				LEFT: begin
					if (bump_left || (bump_left && bump_right))
						state <= RIGHT;
					else if (bump_right)
						state <= LEFT;
					else
						state <= LEFT;
				end
				
				RIGHT: begin
					if (bump_right || (bump_left && bump_right))
						state <= LEFT;
					else if (bump_left)
						state <= RIGHT;
					else
						state <= RIGHT;
				end
			endcase
		end
	end
	
	// Output assignments
	always @(state) begin
		case (state)
			LEFT: begin
				walk_left_int <= 1;
				walk_right_int <= 0;
			end
			
			RIGHT: begin
				walk_left_int <= 0;
				walk_right_int <= 1;
			end
		endcase
	end
			
	// Output delay
	always @(posedge clk) begin
		walk_left <= walk_left_int;
		walk_right <= walk_right_int;
	end

endmodule
