module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Generate the values for mux_in[3:0] based on the K-map entries.
    assign mux_in[0] = (~c & d) | (c & d) | (~c & ~d); // For ab = 00
    assign mux_in[1] = 1'b0;                          // For ab = 01
    assign mux_in[2] = (c & d) | (~c & ~d);           // For ab = 11
    assign mux_in[3] = 1'b1;                          // For ab = 10
endmodule
