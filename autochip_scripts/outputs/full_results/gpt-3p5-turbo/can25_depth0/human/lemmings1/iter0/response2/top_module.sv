module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
	
	// Define the two states
	typedef enum logic [1:0] {WALK_LEFT, WALK_RIGHT} state_t;
	reg state_t current_state;

	// Define the state outputs
	assign walk_left = (current_state == WALK_LEFT);
	assign walk_right = (current_state == WALK_RIGHT);
	
	// Define the state transitions and outputs
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			case (current_state)
				WALK_LEFT:
					begin
						if (bump_right)
							current_state <= WALK_RIGHT;
					end
					
				WALK_RIGHT:
					begin
						if (bump_left)
							current_state <= WALK_LEFT;
					end
			endcase
		end
	end

endmodule
