module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wires
	wire [8:0] sum;
	wire signed_overflow;
	
	// Adder
	assign sum = a + b;
	
	// Output port connections
	assign s = sum[7:0];
	assign overflow = signed_overflow;
	
	// Detect overflow
	assign signed_overflow = (a[7] && b[7] && !sum[7]) || (!a[7] && !b[7] && sum[7]);
	
endmodule
