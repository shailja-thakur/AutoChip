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
			
			// Increment thousands digit when ones digit reaches 10
			if (ones_digit == 10)
				thousands_digit <= thousands_digit + 1;
			
			// Reset ones digit to 0 when it reaches 10
			if (ones_digit == 10)
				ones_digit <= 0;
			// Reset tens digit to 0 when it reaches 10
			if (tens_digit == 10)
				tens_digit <= 0;
			// Reset hundreds digit to 0 when it reaches 10
			if (hundreds_digit == 10)
				hundreds_digit <= 0;
			// Reset thousands digit to 0 when it reaches 10
			if (thousands_digit == 10)
				thousands_digit <= 0;
			
			q[3:0] <= ones_digit;
			q[7:4] <= tens_digit;
			q[11:8] <= hundreds_digit;
			q[15:12] <= thousands_digit;
		end
	end
	
endmodule
