module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [3:0] w;

// Define truth table for mux_in[0]
assign w[0] = (c & ~d);

// Define truth table for mux_in[1]
assign w[1] = (~c & ~d);

// Define truth table for mux_in[2]
assign w[2] = (~c & d) | (c & ~d) | (c & d);

// Define truth table for mux_in[3]
assign w[3] = (c & d);

// Four-input multiplexer
assign mux_in[0] = (w[0] & ~a & ~b) | (w[1] & ~a & b) | (w[2] & a & ~b) | (w[3] & a & b);

// Remaining mux_in outputs are connected directly to w outputs
assign mux_in[1] = w[1];
assign mux_in[2] = w[2];
assign mux_in[3] = w[3];

endmodule
