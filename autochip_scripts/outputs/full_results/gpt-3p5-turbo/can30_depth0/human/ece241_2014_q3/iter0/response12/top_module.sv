module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Declare intermediate signals
wire w1, w2, w3, w4;

// Implement the Karnaugh map logic
assign w1 = ~(c & d);
assign w2 = c;
assign w3 = c & ~d;
assign w4 = c | d;

// Connect the intermediate signals to the multiplexer inputs
assign mux_in[0] = w4;
assign mux_in[1] = w1;
assign mux_in[2] = w2;
assign mux_in[3] = w3;

endmodule
