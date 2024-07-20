module top_module(
	input x,
	input y,
	output z);

	// Implementation of the combinational logic circuit
	assign z = (x ^ y) & x;

endmodule
