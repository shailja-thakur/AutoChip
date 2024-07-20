module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    wire c_d, not_c_d, not_c_not_d, c_not_d;

    // Generating intermediate terms
    assign c_d = c & d;
    assign not_c_d = ~c & d;
    assign not_c_not_d = ~c & ~d;
    assign c_not_d = c & ~d;

    // Assigning values to mux_in based on the Karnaugh map
    assign mux_in[0] = c_not_d | c_d;  // 1 | 1 = 1
    assign mux_in[1] = 0;              // 0
    assign mux_in[2] = ~(not_c_not_d | not_c_d); // ~(0 | 1) = 0 -> 1
    assign mux_in[3] = c_not_d;	     // 1

endmodule
