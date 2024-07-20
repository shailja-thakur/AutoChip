module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // According to the Karnaugh map:

    // For ab = 00:
    assign mux_in[0] = d & ~c | c & ~d | c & d; // Simplifies to c | d

    // For ab = 01:
    assign mux_in[1] = 0;  // Always 0

    // For ab = 11:
    assign mux_in[3] = d | ~d;  // Always 1

    // For ab = 10:
    assign mux_in[2] = c | (~d & ~c);  // Simplifies to ~d | c

endmodule
