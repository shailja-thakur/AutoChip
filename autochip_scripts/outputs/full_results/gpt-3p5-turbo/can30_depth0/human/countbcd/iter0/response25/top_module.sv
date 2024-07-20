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
			q <= 0;
		else begin
			if (ena[3])
				ones_digit <= ones_digit + 1;
			if (ena[2])
				tens_digit <= tens_digit + 1;
			if (ena[1])
				hundreds_digit <= hundreds_digit + 1;
			if (ena[1] && hundreds_digit == 9)
				thousands_digit <= thousands_digit + 1;
		end
	end

	assign ena = {ena[3], ena[2], ena[1]};

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else
			q <= {thousands_digit, hundreds_digit, tens_digit, ones_digit};
	end
	
endmodule
