module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Define intermediate wires for the outputs of the 2-to-1 multiplexers
wire w0;
wire w1;
wire w2;
wire w3;

// Connect 'c' and 'd' to the inputs of the 4-to-1 multiplexer
assign mux_in[0] = w0;
assign mux_in[1] = w1;
assign mux_in[2] = w2;
assign mux_in[3] = w3;

// Implement the Karnaugh map using two 2-to-1 multiplexers
// Mux 1: Inputs {c, d} - Select lines {a, b}
assign w0 = (c & ~d) | (d & ~c) | (c & d);
assign w1 = c;
assign w2 = (c & ~d) | (c & d);
assign w3 = (c & ~d) | (d & ~c) | (c & d);

endmodule
