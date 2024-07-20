module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] ab;

    and #(1) u1 (ab[0], c, d);
    not #(1) u2 (ab[1], c);

    assign #1 mux_in[0] = ab[1] & ~ab[0];    // 00
    assign #1 mux_in[1] = ab[1] & ab[0];     // 01
    assign #1 mux_in[2] = ~ab[1] & ~ab[0];   // 11
    assign #1 mux_in[3] = ~ab[1] & ab[0];    // 10

endmodule
