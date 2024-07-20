module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);
	// Define the states
	parameter [1:0] WALK_LEFT = 2'b00;
	parameter [1:0] WALK_RIGHT = 2'b01;
	
	// Define the current state
	reg [1:0] state;
	
	// Define the next state
	reg [1:0] next_state;
	
	// Define the output
	reg output;
	
	// Synchronous state and output update
	always @(posedge clk) begin
		if (areset) begin
			state <= WALK_LEFT; // Reset state to WALK_LEFT
		end else begin
			state <= next_state; // Update state based on next state
		end
		
		case(state)
			WALK_LEFT: begin
				if (bump_right) begin
					next_state = WALK_RIGHT;
				end else begin
					next_state = WALK_LEFT;
				end
				
				output = 0; // Lemming is walking left, so set output to 0
			end
			
			WALK_RIGHT: begin
				if (bump_left) begin
					next_state = WALK_LEFT;
				end else begin
					next_state = WALK_RIGHT;
				end
				
				output = 1; // Lemming is walking right, so set output to 1
			end
		endcase
	end
	
	// Assign the outputs
	assign walk_left = (state == WALK_LEFT) ? 1 : 0;
	assign walk_right = (state == WALK_RIGHT) ? 1 : 0;
endmodule
