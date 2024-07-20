module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	// State encoding
	typedef enum reg {S_LEFT, S_RIGHT} state_t;
	state_t state, next_state;
	
	// Sequential logic: state transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_LEFT; // Asynchronous reset to walk left
		end else begin
			state <= next_state;
		end
	end
	
	// Combinational logic: next state logic
	always @(*) begin
		case (state)
			S_LEFT: begin
				if (bump_left || (bump_left && bump_right)) begin
					next_state = S_RIGHT; // Switch to walk right
				end else begin
					next_state = S_LEFT; // Continue walking left
				end
			end
			S_RIGHT: begin
				if (bump_right || (bump_left && bump_right)) begin
					next_state = S_LEFT; // Switch to walk left
				end else begin
					next_state = S_RIGHT; // Continue walking right
				end
			end
			default: begin
				next_state = S_LEFT; // Default state
			end
		endcase
	end
	
	// Output logic: Moore FSM outputs depend only on the current state
	always @(*) begin
		case (state)
			S_LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			S_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
			end
		endcase
	end

endmodule
