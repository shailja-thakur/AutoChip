module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

// Define the two states
parameter WL = 0;
parameter WR = 1;

// Define the state register
reg state;

// Define the next state logic
always @ (posedge clk or posedge areset) begin
	if (areset)
		state <= WL;
	else begin
		if (state == WL)
			state <= (bump_left) ? WR : WL;
		else if (state == WR)
			state <= (bump_right) ? WL : WR;
		end
	end
end

// Assign the outputs based on the current state
assign walk_left = (state == WL) ? 1'b1 : 1'b0;
assign walk_right = (state == WR) ? 1'b1 : 1'b0;

endmodule
