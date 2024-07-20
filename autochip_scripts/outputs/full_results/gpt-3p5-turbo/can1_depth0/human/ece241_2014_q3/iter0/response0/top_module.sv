module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Declare internal wire variables
wire w1, w2, w3, w4, w5, w6;

// Implement logic gates
andgate G1 (w1, c, d);
andgate G2 (w2, c, ~d);
andgate G3 (w3, ~c, d);
andgate G4 (w4, ~c, ~d);
andgate G5 (w5, ~c, d);
andgate G6 (w6, ~c, ~d);

// Implement multiplexer connections
mux4to1 mux (
    .s({c, d}),
    .in({w4, w2, w1, w6}),
    .out(mux_in)
);

endmodule
