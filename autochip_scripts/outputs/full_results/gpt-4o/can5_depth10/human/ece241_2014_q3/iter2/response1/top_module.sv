module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map

    // ab = 00
    assign mux_in[0] = d & ~c | ~d & c | c & d;  // When ab = 00, the values are 0, 1, 1, 1, so this can be simplified to c | d

    // ab = 01
    assign mux_in[1] = 0;  // All values are 0

    // ab = 11
    assign mux_in[3] = 1;  // When ab = 11, cd values are 1

    // ab = 10
    assign mux_in[2] = ~c | (~d & c) | (~c & d);  // When ab = 10, simplify

endmodule
