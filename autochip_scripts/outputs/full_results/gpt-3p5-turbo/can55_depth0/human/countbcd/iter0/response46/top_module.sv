module top_module(
	input clk,
	input reset,
	output reg [2:0] ena,
	output reg [15:0] q);
	
	reg [3:0] q0, q1, q2, q3;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q0 <= 4'b0000;
		else if (ena[0])
			q0 <= q0 + 1;
		if (reset || ena[0])
			q1 <= 4'b0000;
		else if (ena[1])
			q1 <= q1 + 1;
		if (reset || ena[0] || ena[1])
			q2 <= 4'b0000;
		else if (ena[2])
			q2 <= q2 + 1;
		if (reset || ena[0] || ena[1] || ena[2])
			q3 <= 4'b0000;
		else
			q3 <= q3 + 1;
	end
	
	assign q = {q3, q2, q1, q0};
	
endmodule
