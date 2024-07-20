module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Parameters representing the two states
	localparam WL = 1'b0;
	localparam WR = 1'b1;

	// Register to hold the current state
	reg state, next_state;

	// State transition logic (Combinational logic)
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
			default: next_state = WL;
		endcase
	end

	// State register update (Sequential logic)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;  // Reset to the initial state
		else
			state <= next_state;  // Update state on rising edge of clk
		end
	end

	// Output logic
	assign walk_left = (state == WL);
	assign walk_right = (state == WR);

endmodule
