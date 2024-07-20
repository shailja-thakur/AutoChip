module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define states
	typedef enum logic [1:0] {
		LEFT,
		RIGHT
	} State;

	// Declare state and outputs
	State current_state;
	logic walk_left;
	logic walk_right;

	// Define state transition and output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= LEFT; // Reset to initial state
		end else begin
			case (current_state)
				LEFT: begin
					if (bump_right)
						current_state <= RIGHT;
					else if (bump_left)
						current_state <= LEFT;
				end
				RIGHT: begin
					if (bump_left)
						current_state <= LEFT;
					else if (bump_right)
						current_state <= RIGHT;
				end
				default: current_state <= LEFT;
			endcase
		end
		
		case (current_state)
			LEFT: begin
				walk_left = 1; // Lemming is walking left
				walk_right = 0;
			end
			RIGHT: begin
				walk_left = 0;
				walk_right = 1; // Lemming is walking right
			end
		endcase
	end
	
endmodule
