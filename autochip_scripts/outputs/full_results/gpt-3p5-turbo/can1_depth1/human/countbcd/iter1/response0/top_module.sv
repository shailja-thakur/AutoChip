module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	// Internal signals
	reg [3:0] ones_reg;
	reg [3:0] tens_reg;
	reg [3:0] hunds_reg;
	reg [3:0] thous_reg;

	// Reset
	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			q <= 0;
			ones_reg <= 0;
			tens_reg <= 0;
			hunds_reg <= 0;
			thous_reg <= 0;
		end
		else
		begin
			if (ena[1])
				ones_reg <= ones_reg + 1;

			if (ena[2])
				tens_reg <= tens_reg + 1;

			if (ena[3])
				hunds_reg <= hunds_reg + 1;

			q[3:0] <= ones_reg;
			q[7:4] <= tens_reg;
			q[11:8] <= hunds_reg;
			q[15:12] <= thous_reg;
		end
	end

	// Output assignment
	assign ena = {1'b1, ena[2:1]};

endmodule
