module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Intermediate wires for the 2-to-1 multiplexers
	wire w0, w1, w2, w3;

	// Implementing Karnaugh map using 2-to-1 multiplexers
	// w0 = ~(~c & ~d) = c + d
	assign w0 = c | d;

	// w1 = ~(~c & d) = c + ~d
	assign w1 = c | ~d;

	// w2 = ~(c & d) = ~c + ~d
	assign w2 = ~c | ~d;

	// w3 = ~(c & ~d) = ~c + d
	assign w3 = ~c | d;

	// Implementing 4-to-1 multiplexer
	assign mux_in[0] = w0 & ~a & ~b;
	assign mux_in[1] = w1 & ~a & b;
	assign mux_in[2] = w2 & a & b;
	assign mux_in[3] = w3 & a & ~b;

endmodule
