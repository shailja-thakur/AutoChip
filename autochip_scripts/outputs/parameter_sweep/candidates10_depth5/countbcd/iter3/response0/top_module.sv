module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] q_ones;
	reg [3:0] q_tens;
	reg [3:0] q_hundreds;
	
	always @(posedge clk) begin
		if (reset)
			begin
				q_ones <= 4'b0000;
				q_tens <= 4'b0000;
				q_hundreds <= 4'b0000;
			end
		else
			begin
				if (ena[1] && q_ones == 4'b1001)
					q_ones <= 4'b0000;
				else if (ena[2] && q_tens == 4'b1001)
					q_tens <= 4'b0000;
				else if (ena[3] && q_hundreds == 4'b1001)
					q_hundreds <= 4'b0000;
				else
					q_ones <= q_ones + 1;
				
				if (ena[2] && q_ones == 4'b1001)
					q_tens <= q_tens + 1;
				
				if (ena[3] && q_tens == 4'b1001)
					q_hundreds <= q_hundreds + 1;
			end
	end

	assign ena = q_hundreds != 4'b111;
	assign q = {q_hundreds, q_tens, q_ones};
	
endmodule
