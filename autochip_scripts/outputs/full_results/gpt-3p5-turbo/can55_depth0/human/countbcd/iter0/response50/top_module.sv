module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] ones_digit;
	reg [3:0] tens_digit;
	reg [3:0] hundreds_digit;
	reg [3:0] thousands_digit;
	
	// Initialize all digits to zero
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			ones_digit <= 4'b0000;
			tens_digit <= 4'b0000;
			hundreds_digit <= 4'b0000;
			thousands_digit <= 4'b0000;
		end else begin
			ones_digit <= ones_digit + ena[0];
			tens_digit <= tens_digit + ena[1];
			hundreds_digit <= hundreds_digit + ena[2];
			thousands_digit <= thousands_digit + ena[3];
		end
	end
	
	// Combine the digits to form the output
	always @(ones_digit, tens_digit, hundreds_digit, thousands_digit) begin
		q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
	end
endmodule
