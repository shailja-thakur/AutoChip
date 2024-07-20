module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	// State definitions
	typedef enum logic [1:0] {
		LEFT = 2'b01,
		RIGHT = 2'b10
	} state_t;

	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			LEFT: begin
				if (bump_left || (bump_left && bump_right)) begin
					next_state = RIGHT;
				end else begin
					next_state = LEFT;
				end
			end
			RIGHT: begin
				if (bump_right || (bump_left && bump_right)) begin
					next_state = LEFT;
				end else begin
					next_state = RIGHT;
				end
			end
			default: next_state = LEFT; // This should never happen
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
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
				walk_left = 1;
				walk_right = 0;
			end
		endcase
	end

endmodule
