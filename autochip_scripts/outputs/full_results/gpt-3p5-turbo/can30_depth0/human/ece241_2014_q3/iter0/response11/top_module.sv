module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Intermediate wires
	wire f1, f2, f3, f4, f5, f6, f7, f8;

	// Implementing the Karnaugh map
	assign f1 = c & ~d;
	assign f2 = c & ~d;
	assign f3 = c & ~d;
	assign f4 = ~c & ~d;
	assign f5 = c & d;
	assign f6 = ~c & d;
	assign f7 = c & d;
	assign f8 = c & d;

	// Multiplexer connections
	assign mux_in[0] = f1;
	assign mux_in[1] = f2;
	assign mux_in[2] = f3;
	assign mux_in[3] = f4;

	// 4-to-1 Multiplexer
	// Note: a and b are connected to select inputs of the multiplexer
	// depending on their binary representation, as shown below.
	// ab = 00, mux_in[0] is selected
	// ab = 01, mux_in[1] is selected
	// ab = 10, mux_in[2] is selected
	// ab = 11, mux_in[3] is selected
	// Since there are multiple occurrences of the same output in the K-map,
	// the corresponding f values are connected to multiple mux inputs.
	// The multiplexer is used to select the correct output based on a and b.

	endmodule
