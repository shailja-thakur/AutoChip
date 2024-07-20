module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Create signals for storing the current state of each digit
	reg [3:1] ones_digit;
	reg [3:1] tens_digit;
	reg [3:1] hundreds_digit;
	reg [3:1] thousands_digit;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset all digits to zero
			ones_digit <= 0;
			tens_digit <= 0;
			hundreds_digit <= 0;
			thousands_digit <= 0;
		end else begin
			// Increment the ones digit every clock cycle
			ones_digit <= ones_digit + 1;
			
			// Increment the tens digit only when enabled
			if (ena[1])
				tens_digit <= tens_digit + 1;
			
			// Increment the hundreds digit only when enabled
			if (ena[2])
				hundreds_digit <= hundreds_digit + 1;
			
			// Increment the thousands digit only when enabled
			if (ena[3])
				thousands_digit <= thousands_digit + 1;
		end
	end
	
	// Combine the digits into a 4-digit BCD counter
	assign q = {ones_digit, tens_digit, hundreds_digit, thousands_digit};
endmodule
