module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map

    // ab = 00
    assign mux_in[0] = d & c;

    // ab = 01
    assign mux_in[1] = ~d & c;

    // ab = 11
    assign mux_in[3] = d;

    // ab = 10
    assign mux_in[2] = d | ~c;

endmodule
