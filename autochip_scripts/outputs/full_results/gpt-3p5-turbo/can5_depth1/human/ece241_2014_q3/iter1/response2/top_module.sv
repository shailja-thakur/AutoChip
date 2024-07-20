module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire w1, w2, w3, w4;

    // Implementing K-map using 2-to-1 multiplexers
    assign w1 = ~(c & d);
    assign w2 = c & (~d);
    assign w3 = (c & ~d) | (~c & d);
    assign w4 = (c & d) | (~c & ~d);

    // Connecting outputs of 2-to-1 multiplexers to 4-to-1 multiplexer inputs
    assign mux_in[0] = w1;
    assign mux_in[1] = w2;
    assign mux_in[2] = w3;
    assign mux_in[3] = w4;

endmodule
