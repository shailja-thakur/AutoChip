module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] q1, q2, q3, q4;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q1 <= 4'b0000;
			q2 <= 4'b0000;
			q3 <= 4'b0000;
			q4 <= 4'b0000;
		else if (ena[3])
			q1 <= q1 + 1;
		if (ena[2])
			q2 <= q2 + 1;
		if (ena[1])
			q3 <= q3 + 1;
		if (ena[1] && q3 == 9)
			q4 <= q4 + 1;
		if (ena[1] && q3 == 9 && q4 == 10)
			q4 <= 0;
	end

	assign q = {q4, q3, q2, q1};
endmodule
