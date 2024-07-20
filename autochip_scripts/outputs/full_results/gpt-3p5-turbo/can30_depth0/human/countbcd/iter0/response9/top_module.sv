module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] q0, q1, q2, q3;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 4'b0;
		else if (ena[3])
			q <= {q1[3:0], q2[3:0], q3[3:0], q0[3:0]} + 1;
		else
			q <= {q1[3:0], q2[3:0], q3[3:0], q0[3:0]};
			
		if (ena[2])
			q0 <= q0 + 1;
		if (ena[1])
			q1 <= q1 + 1;
		if (ena[0])
			q2 <= q2 + 1;
		q3 <= q3 + 1;
	end
	
	assign ena = {reset, q3[3], q2[3], q1[3]};
endmodule
