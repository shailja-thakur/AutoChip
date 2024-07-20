module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);
	
	// Declare the state enumeration
	typedef enum logic [1:0] {
		LEFT,
		RIGHT
	} state_t;
	
	reg [1:0] current_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset, set initial state
			current_state <= LEFT;
		end else begin
			// State transition logic
			case (current_state)
				LEFT: begin
					if (bump_right) begin
						current_state <= RIGHT;
					end
				end
				RIGHT: begin
					if (bump_left) begin
						current_state <= LEFT;
					end
				end
				default: begin
					// Default case, stay in current state
				end
			endcase
		end
	end
	
	// Output logic
	always @(current_state) begin
		case (current_state)
			LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			RIGHT: begin
				walk_left = 0;
				walk_right = 1;
			end
			default: begin
				// Default case, should not reach here
				walk_left = 0;
				walk_right = 0;
			end
		endcase
	end

endmodule
