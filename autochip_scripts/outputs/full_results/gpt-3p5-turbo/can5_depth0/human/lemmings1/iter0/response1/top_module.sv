module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define the states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT
	} state_type;
	
	// Declare the state and output variables
	state_type current_state;
	logic walk;
	
	// Reset state on positive edge of areset
	always_ff @(posedge areset) begin
		current_state <= WALK_LEFT;
		walk <= 1'b0;
	end
	
	// Define the state transition logic
	always_ff @(posedge clk) begin
		case (current_state)
			WALK_LEFT: begin
				if (bump_right)
					current_state <= WALK_RIGHT;
			end
			
			WALK_RIGHT: begin
				if (bump_left)
					current_state <= WALK_LEFT;
			end
		endcase
	end
	
	// Define the output logic
	always_comb begin
		case (current_state)
			WALK_LEFT: begin
				walk_left = 1'b1;
				walk_right = 1'b0;
			end
			
			WALK_RIGHT: begin
				walk_left = 1'b0;
				walk_right = 1'b1;
			end
		endcase
	end

endmodule
