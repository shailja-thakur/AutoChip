module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Adder to compute the sum
	// Use a + b as operands
	// Result stored in s
	// Overflow flag set based on MSB carry out
	assign s = a + b;
	
	// Calculate the carry out of MSB
	reg carryOut;
	always @* begin
		carryOut = (a[7] & b[7]) | (s[7] & (~a[7]) & (~b[7]));
	end
	
	// Assign carryOut to overflow
	assign overflow = carryOut;

endmodule
