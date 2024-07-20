module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal wire for sum overflow
	wire sum_overflow;

	// Declare internal wire for sum
	wire [8:0] sum;
	
	// Adder module to perform addition of a and b
	adder adder_inst (
		.a(a),
		.b(b),
		.sum(sum),
		.overflow(sum_overflow)
	);
	
	// Assign s from sum, excluding overflow bit
	assign s = sum[7:0];
	
	// Assign overflow output
	assign overflow = sum_overflow;

endmodule
module adder (
	input [7:0] a,
	input [7:0] b,
	output [8:0] sum,
	output overflow
);

	// Declare internal wire for carry
	wire carry;
	
	// Declare internal wire for sum overflow
	wire sum_overflow;
	
	// Adder implementation
	assign {carry, sum[7:0]} = a + b;
	
	// Assign sum overflow
	assign sum_overflow = carry ^ a[7] ^ b[7];
	
	// Assign sum with overflow bit
	assign sum[8] = sum_overflow;

	// Assign overflow output
	assign overflow = sum_overflow;

endmodule
