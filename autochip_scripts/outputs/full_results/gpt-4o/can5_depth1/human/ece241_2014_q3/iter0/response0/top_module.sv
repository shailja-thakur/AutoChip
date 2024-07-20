module top_module (
    input  c,
    input  d,
    output [3:0] mux_in
);

    // Assigning the values to mux_in based on the given K-map
    assign mux_in[0] = (~c & ~d) | (c & ~d) | (c & d);  // This simplifies to `1`
    assign mux_in[1] = 0;                              // K-map value for ab=01 is always 0
    assign mux_in[2] = (c & d);                        // K-map value for ab=11 is `cd`
    assign mux_in[3] = (~c & d) | (c & ~d) | (c & d);  // This simplifies to `c ^ d`

endmodule
