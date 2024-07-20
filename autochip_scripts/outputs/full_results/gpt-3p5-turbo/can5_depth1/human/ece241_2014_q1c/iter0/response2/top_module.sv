module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire
	wire [8:0] sum;

	// Adder module instance
	adder adder1 (.a(a), .b(b), .s(sum));

	// Assign output s[7:0]
	assign s = sum[7:0];

	// Assign overflow output
	assign overflow = (sum[8] == 1);

endmodule
module adder (
	input [7:0] a,
	input [7:0] b,
	output [8:0] s
);
	
	assign s = a + b;

endmodule
