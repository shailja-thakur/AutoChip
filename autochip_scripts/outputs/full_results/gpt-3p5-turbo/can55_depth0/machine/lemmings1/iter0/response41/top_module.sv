module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	parameter WL = 0;
	parameter WR = 1;

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else begin
			if (state == WL) begin
				if (bump_left)
					state <= WR;
				else
					state <= WL;
			end else if (state == WR) begin
				if (bump_right)
					state <= WL;
				else
					state <= WR;
			end
		end
	end

	always @(state) begin
		if (state == WL) begin
			walk_left = 1;
			walk_right = 0;
		end else if (state == WR) begin
			walk_left = 0;
			walk_right = 1;
		end
	end
	
endmodule
