module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	// Define internal reg signals
	reg [3:0] ones_digit;
	reg [3:0] tens_digit;
	reg [3:0] hundreds_digit;
	reg [3:0] thousands_digit;
	
	// Implement the counter logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 16'b0000_0000_0000_0000; // Reset the counter to 0
		else if (ena[1])
			tens_digit <= tens_digit + 1'b1; // Increment tens digit
		else if (ena[2])
			hundreds_digit <= hundreds_digit + 1'b1; // Increment hundreds digit
		else if (ena[3])
			thousands_digit <= thousands_digit + 1'b1; // Increment thousands digit
		else if (ena[0])
			ones_digit <= ones_digit + 1'b1; // Increment ones digit
	end
	
	// Combine the digits to form the BCD counter
	assign q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
	
endmodule
