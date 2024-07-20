module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Intermediate signals
wire w1, w2, w3, w4;

// Logic for w1
and (w1, c, d);

// Logic for w2
and (w2, c, ~d);

// Logic for w3
and (w3, ~c, d);

// Logic for w4
and (w4, ~c, ~d);

// 4-to-1 multiplexer
assign mux_in[0] = (w4 & ~a & ~b) | (w3 & ~a & b) | (w2 & a & ~b) | (w1 & a & b);
assign mux_in[1] = (w4 & ~a & ~b) | (w3 & ~a & b) | (w2 & a & ~b) | (w1 & a & b);
assign mux_in[2] = (w4 & ~a & ~b) | (w3 & ~a & b) | (w2 & a & ~b) | (w1 & a & b);
assign mux_in[3] = (w4 & ~a & ~b) | (w3 & ~a & b) | (w2 & a & ~b) | (w1 & a & b);

endmodule
