module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Declare internal wires
	wire w1, w2, w3, w4, w5;

	// Logic gates
	assign w1 = !(a & b) & !(c | d);
	assign w2 = !w1;
	assign w3 = w2 & !c;
	assign w4 = w2 & d;
	assign w5 = w3 | w4;

	// Output
	assign q = w5;

endmodule
