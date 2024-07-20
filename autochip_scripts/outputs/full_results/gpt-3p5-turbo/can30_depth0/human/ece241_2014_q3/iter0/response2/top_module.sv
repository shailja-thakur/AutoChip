module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Define internal wires
wire w0, w1, w2, w3, w4, w5, w6, w7;

// Implement Karnaugh map using 2-to-1 multiplexers
assign w0 = c & ~d;
assign w1 = c & ~d;
assign w2 = c | ~d;
assign w3 = c;
assign w4 = c & ~d;
assign w5 = 1'b1;
assign w6 = c | ~d;
assign w7 = c | ~d;

// Implement 4-to-1 multiplexer
assign mux_in[0] = (c & ~d) ? w0 : w4;
assign mux_in[1] = (c & ~d) ? w1 : w5;
assign mux_in[2] = (c & ~d) ? w2 : w6;
assign mux_in[3] = (c & ~d) ? w3 : w7;

endmodule
