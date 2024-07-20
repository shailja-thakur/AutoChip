module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define the states
	enum {STATE_LEFT, STATE_RIGHT} state;

	// Define the outputs
	assign walk_left = (state == STATE_LEFT);
	assign walk_right = (state == STATE_RIGHT);

	// Define the next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_LEFT;
		end else begin
			if (bump_left && !bump_right) begin
				state <= STATE_RIGHT;
			end else if (!bump_left && bump_right) begin
				state <= STATE_LEFT;
			end else begin
				state <= state;
			end
		end
	end

endmodule
