module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Create wire for sum
	wire [8:0] sum;
	
	// Assign output s to the 8 least significant bits of the sum
	assign s = sum[7:0];
	
	// Assign overflow output
	assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

	// Instantiate module to add two 8-bit numbers
	adder add (
		.a(a),
		.b(b),
		.sum(sum)
	);
	
endmodule
module adder (
	input [7:0] a,
	input [7:0] b,
	output [8:0] sum
);
	
	// Generate carry
	wire [8:0] carry;
	assign carry[0] = 1'b0;
	
	// Generate sum
	assign sum = a + b + carry;
	
endmodule
