module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implementing the K-map using minimum multiplexers
    wire mid1, mid2, mid3;

    // Define intermediate signals for the mux inputs
    // mux_in[0] = d
    // mux_in[1] = 0
    // mux_in[2] = c & ~d
    // mux_in[3] = 1

    // Implementing mux_in[2] using 2-to-1 multiplexers with inputs c, ~d
    assign mid1 = ~d;
    assign mid2 = c & mid1;
    assign mux_in[2] = mid2;

    // Directly assigning other values as no multiplexers required
    assign mux_in[0] = d;
    assign mux_in[1] = 0;
    assign mux_in[3] = 1;

endmodule
