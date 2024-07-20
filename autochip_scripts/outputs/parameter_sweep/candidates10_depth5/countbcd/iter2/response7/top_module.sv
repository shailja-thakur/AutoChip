module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] ones_digit;
	reg [3:0] tens_digit;
	reg [3:0] hundreds_digit;
	reg [3:0] thousands_digit;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 16'b0000;
		else if (ena[0])
			ones_digit <= ones_digit + 1;
		else if (ena[1])
			tens_digit <= tens_digit + 1;
		else if (ena[2])
			hundreds_digit <= hundreds_digit + 1;
		else if (ena[3])
			thousands_digit <= thousands_digit + 1;
	end

	always @(ones_digit, tens_digit, hundreds_digit, thousands_digit) begin
		q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
	end

	assign ena = q[15:13] != 3'b111;
	
endmodule
