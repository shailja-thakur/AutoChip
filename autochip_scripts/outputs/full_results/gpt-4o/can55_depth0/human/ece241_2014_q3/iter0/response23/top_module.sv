module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implement the K-map logic using as few 2-to-1 multiplexers as possible
    // Use _a_ and _b_ as the 4-to-1 multiplexer selector inputs

    // mux_in[0] corresponds to ab = 00
    assign mux_in[0] = (c & ~d) | (d & ~c) | (c & d);

    // mux_in[1] corresponds to ab = 01
    assign mux_in[1] = 0;

    // mux_in[2] corresponds to ab = 11
    assign mux_in[2] = (c & ~d) | (c & d);

    // mux_in[3] corresponds to ab = 10
    assign mux_in[3] = (c & ~d) | (d & ~c) | (c & d);

endmodule
