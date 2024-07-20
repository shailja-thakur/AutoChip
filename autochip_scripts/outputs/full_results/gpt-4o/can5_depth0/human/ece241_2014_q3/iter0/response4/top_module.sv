module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Allocate the outputs of the 2-to-1 multiplexers
    wire cd0, cd1, cd2, cd3;

    // Each mux_in[n] should be set based on the values in the K-map
    // mux_in[0] corresponds to ab = 00
    assign mux_in[0] = (c & d) | (~c & d);

    // mux_in[1] corresponds to ab = 01
    assign mux_in[1] = 0; // As all values related to ab = 01 are 0

    // mux_in[2] corresponds to ab = 10
    assign mux_in[2] = d; // Because c'd

    // mux_in[3] corresponds to ab = 11
    assign mux_in[3] = c | ~c; // Which is always 1 as per Karnaugh map

endmodule
