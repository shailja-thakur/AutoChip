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
			q <= 16'b0000;
		else begin
			if (ena[1]) begin
				if (q_ones == 4'b1001)
					q_ones <= 4'b0000;
				else
					q_ones <= q_ones + 1;
			end
			if (ena[2]) begin
				if (q_tens == 4'b1001)
					q_tens <= 4'b0000;
				else
					q_tens <= q_tens + 1;
			end
			if (ena[3]) begin
				if (q_hundreds == 4'b1001)
					q_hundreds <= 4'b0000;
				else
					q_hundreds <= q_hundreds + 1;
			end
			q_thousands <= q_thousands + 1;
		end
	end

	assign q = {q_thousands, q_hundreds, q_tens, q_ones};

endmodule
