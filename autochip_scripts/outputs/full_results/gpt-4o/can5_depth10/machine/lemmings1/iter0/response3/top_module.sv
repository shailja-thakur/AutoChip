module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	// Define states
	parameter WL = 1'b0, WR = 1'b1;
	
	// Current state register
	reg state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			WL: begin
				if (bump_left)
					next_state = WR;
				else
					next_state = WL;
			end
			WR: begin
				if (bump_right)
					next_state = WL;
				else
					next_state = WR;
			end
			default: next_state = WL; // Default state to handle any unforeseen states
		endcase
	end

	// State register logic (sequential logic)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else
			state <= next_state;
	end

	// Output logic based on state
	always @(*) begin
		case (state)
			WL: begin
				walk_left = 1;
				walk_right = 0;
			end
			WR: begin
				walk_left = 0;
				walk_right = 1;
			end
			default: begin
				walk_left = 0;
				walk_right = 0; // Default outputs to handle any unforeseen states
			end
		endcase
	end

endmodule
