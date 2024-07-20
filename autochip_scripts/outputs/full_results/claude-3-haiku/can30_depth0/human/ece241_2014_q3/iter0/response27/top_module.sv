module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire w1, w2;

    // Implement the first 2-to-1 multiplexer
    assign w1 = (c & d) | (~c & d);

    // Implement the second 2-to-1 multiplexer
    assign w2 = (c & ~d) | (~c & d);

    // Implement the 4-to-1 multiplexer
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = w2;
    assign mux_in[3] = w1;

endmodule
