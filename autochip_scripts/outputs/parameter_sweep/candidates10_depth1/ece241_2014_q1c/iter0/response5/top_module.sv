module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	// Intermediate wire to store the sum of a and b
	wire [7:0] sum;
	
	// Intermediate wire to check for overflow
	wire carry_out;
	
	// Adder module to perform sum of a and b
	adder adder1(
		.a(a),
		.b(b),
		.sum(sum),
		.carry_out(carry_out)
	);
	
	// Assign the sum output to the s output port
	assign s = sum;
	
	// Check for overflow by comparing the sign bits of a, b, and sum
	assign overflow = (a[7] == b[7] && a[7] != s[7]) ? 1'b1 : 1'b0;
	
endmodule
