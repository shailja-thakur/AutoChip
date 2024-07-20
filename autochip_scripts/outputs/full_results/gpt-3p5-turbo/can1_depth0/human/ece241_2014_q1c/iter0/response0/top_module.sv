module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal wires
	wire [8:0] sum;
	wire carry;

	// Adder
	assign sum = a + b;
	assign carry = (sum[8] == 1);

	// Output wires
	assign s = sum[7:0];
	assign overflow = carry;

endmodule
