module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Define the mux inputs based on the given K-map
    assign mux_in[0] = (c & ~d) | (~c & d) | (c & d);  // ab = 00, K-map outputs: 0 | 1 | 1 | 1
    assign mux_in[1] = (c & ~d);                      // ab = 01, K-map outputs: 0 | 0 | 0 | 0
    assign mux_in[2] = (c & d) | (~c & d);            // ab = 11, K-map outputs: 0 | 0 | 1 | 0
    assign mux_in[3] = (~d) | (c & d);                // ab = 10, K-map outputs: 1 | 0 | 1 | 1
endmodule
