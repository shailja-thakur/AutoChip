module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire ab_00, ab_01, ab_11, ab_10;

    // k-map implementation using 2-to-1 multiplexers
    // mux_in[3] = 1'b0
    assign mux_in[3] = c & d;

    // mux_in[2] = 1'b0
    assign mux_in[2] = ~d;

    // mux_in[1]
    assign mux_in[1] = ~c & ~d;

    // mux_in[0]
    assign mux_in[0] = c | (~c & ~d);

    // connecting 4-to-1 multiplexer to mux_in
    assign ab_00 = 1'b0;
    assign ab_01 = 1'b1;
    assign ab_11 = c;
    assign ab_10 = ~c;
    
    // 4-to-1 multiplexer
    assign mux_in = (ab_00 & mux_in[0]) | (ab_01 & mux_in[1]) | (ab_11 & mux_in[2]) | (ab_10 & mux_in[3]);

endmodule
