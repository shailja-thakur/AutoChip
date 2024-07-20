module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// State parameters
	parameter WL = 0;
	parameter WR = 1;
	
	// State register
	reg [1:0] state;
	
	// Next state logic
	always @ (posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else if (state == WL)
			state <= (bump_left) ? WR : WL;
		else if (state == WR)
			state <= (bump_right) ? WL : WR;
	end
	
	// Output assignment
	assign walk_left = (state == WL) ? 1'b1 : 1'b0;
	assign walk_right = (state == WR) ? 1'b1 : 1'b0;

endmodule
