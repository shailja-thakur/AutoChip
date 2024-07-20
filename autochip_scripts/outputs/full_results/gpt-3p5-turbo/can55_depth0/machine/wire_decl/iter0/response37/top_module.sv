module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Declare internal wires
	wire w1;
	wire w2;

	// Assign values to wires
	assign w1 = a & b;  // Logical AND of inputs a and b
	assign w2 = c & d;  // Logical AND of inputs c and d

	// Assign values to outputs
	assign out = w1 | w2;  // Logical OR of wires w1 and w2
	assign out_n = ~out;   // Logical NOT of output out

endmodule
