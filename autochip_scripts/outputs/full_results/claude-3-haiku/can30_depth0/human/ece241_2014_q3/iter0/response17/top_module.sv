module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire and1, and2, and3;
    wire or1, or2;

    // Implement the Karnaugh map using multiplexers
    assign and1 = c & ~d;
    assign and2 = ~c & d;
    assign and3 = c & d;

    assign or1 = and1 | and2;
    assign or2 = and2 | and3;

    assign mux_in[0] = 1'b1;
    assign mux_in[1] = or1;
    assign mux_in[2] = and3;
    assign mux_in[3] = or2;

endmodule
