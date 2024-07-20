module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Internal signals
	reg [3:0] ones_digit;
	reg [3:0] tens_digit;
	reg [3:0] hundreds_digit;
	reg [3:0] thousands_digit;
	
	// Assigning decimal digits
	assign ones_digit = q[3:0];
	assign tens_digit = q[7:4];
	assign hundreds_digit = q[11:8];
	assign thousands_digit = q[15:12];
	
	// Counter logic
	always @(posedge clk) begin
		if (reset)
			q <= 16'b0000;
		else if (ena[1])
			ones_digit <= ones_digit + 1;
		else
			ones_digit <= ones_digit;
			
		if (ena[2])
			tens_digit <= tens_digit + 1;
		else
			tens_digit <= tens_digit;
			
		if (ena[3])
			hundreds_digit <= hundreds_digit + 1;
		else
			hundreds_digit <= hundreds_digit;
			
		thousands_digit <= thousands_digit + 1;
	end
	
	// Output assignment
	assign q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
endmodule
