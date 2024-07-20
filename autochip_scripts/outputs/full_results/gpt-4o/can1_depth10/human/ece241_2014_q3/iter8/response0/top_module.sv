module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values to the 4-to-1 multiplexer inputs based on the given K-map
    assign mux_in[0] = 1'b0;          // cd = 00 -> 0
    assign mux_in[1] = d;             // cd = 01 -> d
    assign mux_in[2] = c;             // cd = 11 -> c
    assign mux_in[3] = 1'b1;          // cd = 10 -> 1

endmodule
