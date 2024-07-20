module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire and1, and2, or1;

    assign and1 = ~c & ~d;
    assign and2 = c & d;
    assign or1 = ~c & d | c & ~d;

    assign mux_in[0] = and1;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = and2 | or1;
    assign mux_in[3] = and2 | ~c & d | c & ~d;

endmodule
