module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] q0;
	reg [3:0] q1;
	reg [3:0] q2;
	reg [3:0] q3;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else if (ena[0])
			q0 <= q0 + 1;
		else if (ena[1])
			q1 <= q1 + 1;
		else if (ena[2])
			q2 <= q2 + 1;
		else if (ena[3])
			q3 <= q3 + 1;
	end
	
	assign q = {q3, q2, q1, q0};

endmodule
