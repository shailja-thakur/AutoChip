module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] q_ones;
	reg [3:0] q_tens;
	reg [3:0] q_hundreds;
	reg [3:0] q_thousands;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			if (ena[1])
				q_ones <= q_ones + 1;
			if (ena[2])
				q_tens <= q_tens + 1;
			if (ena[3])
				q_hundreds <= q_hundreds + 1;
			q_thousands <= q_thousands + 1;
			q <= {q_thousands, q_hundreds, q_tens, q_ones};
		end
	end
	
	assign ena = {1'b1, ena[2:1]};
	
endmodule
