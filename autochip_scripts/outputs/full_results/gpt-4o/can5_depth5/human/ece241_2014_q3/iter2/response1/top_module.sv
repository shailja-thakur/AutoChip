module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Based on the K-map, we need to define the 4-to-1 mux inputs:
    // mux_in[0] corresponds to ab = 00
    // mux_in[1] corresponds to ab = 01
    // mux_in[2] corresponds to ab = 11
    // mux_in[3] corresponds to ab = 10

    assign mux_in[0] = ~c & d | c; // Output is 1 for (c,d) = 01, 10, 11
    assign mux_in[1] = 1'b0; // Always 0 for (a,b) = 01
    assign mux_in[2] = c & d | c & ~d; // Output is 1 for (c,d) = 10, 11
    assign mux_in[3] = ~c & ~d | c; // Output is 1 for (c,d) = 00, 10, 11

endmodule
