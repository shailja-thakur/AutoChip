module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define the states
	parameter LEFT = 0;
	parameter RIGHT = 1;
	
	// Define the internal state register
	reg [1:0] state;
	
	// Define the output register
	reg walk_left;
	reg walk_right;
	
	// Asynchronous reset
	always @(posedge areset)
		begin
			state <= LEFT;
		end
	
	// State transition and output logic
	always @(posedge clk)
		begin
			case(state)
				LEFT:
					begin
						if(bump_right)
							state <= RIGHT;
					end
				RIGHT:
					begin
						if(bump_left)
							state <= LEFT;
					end
			endcase
			
			case(state)
				LEFT: 
					begin
						walk_left <= 1;
						walk_right <= 0;
					end
				RIGHT:
					begin
						walk_left <= 0;
						walk_right <= 1;
					end
			endcase
		end

endmodule
