module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Define internal wires
wire w1, w2, w3;

// Implement logic for w1
assign w1 = ~c & d;

// Implement logic for w2
assign w2 = c & ~d;

// Implement logic for w3
assign w3 = c & d;

// Implement 4-to-1 multiplexer
assign mux_in[0] = w3;
assign mux_in[1] = w1;
assign mux_in[2] = w2;
assign mux_in[3] = w3;

endmodule
