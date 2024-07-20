module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Declare internal wires
	wire w1, w2, w3, w4, w5;

	// Generate the expressions for internal wires
	assign w1 = ~c & d;
	assign w2 = c & ~d;
	assign w3 = ~(c ^ d);
	assign w4 = c & d;
	assign w5 = ~(c | d);

	// Connect the internal wires to the multiplexer inputs
	assign mux_in[0] = w1;
	assign mux_in[1] = w2;
	assign mux_in[2] = w3;
	assign mux_in[3] = w4;

endmodule
