module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	// Internal wire declarations
	wire carry;
	
	// Full adder module declaration
	// This module adds two bits along with a carry-in to produce the sum and carry-out
	// It is reused to add each bit of the two 8-bit numbers
	// The sum output represents a single bit and the carry output represents the carry-out
	// from adding the two input bits along with the carry-in
	module full_adder (
		input a,
		input b,
		input carry_in,
		output sum,
		output carry_out
	);
		assign {sum, carry_out} = a + b + carry_in;
	endmodule
module full_adder (
	input a,
	input b,
	input carry_in,
	output sum,
	output carry_out
);
	assign {sum, carry_out} = a + b + carry_in;
endmodule
