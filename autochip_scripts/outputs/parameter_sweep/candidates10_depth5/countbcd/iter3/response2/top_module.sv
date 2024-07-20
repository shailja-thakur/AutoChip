module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] ones_digit;
	reg [3:0] tens_digit;
	reg [3:0] hundreds_digit;
	reg [3:0] thousands_digit;
	
	always @(posedge clk) begin
		if (reset)
			q <= 16'b0000;
		else if (ena[1] && ones_digit == 4'b1001)
			ones_digit <= 4'b0000;
		else if (ena[2] && tens_digit == 4'b1001)
			tens_digit <= 4'b0000;
		else if (ena[3] && hundreds_digit == 4'b1001)
			hundreds_digit <= 4'b0000;
		else if (q[3:0] != 4'b1001)
			ones_digit <= ones_digit + 1;
		else if (q[7:4] != 4'b1001)
			tens_digit <= tens_digit + 1;
		else if (q[11:8] != 4'b1001)
			hundreds_digit <= hundreds_digit + 1;
		else
			thousands_digit <= thousands_digit + 1;
	end

	assign ena = q[15:13] != 3'b111;
	assign q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
	
endmodule
