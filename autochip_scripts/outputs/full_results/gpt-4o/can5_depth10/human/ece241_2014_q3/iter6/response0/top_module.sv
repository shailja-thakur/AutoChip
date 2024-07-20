module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map

    // ab = 00
    assign mux_in[0] = ~c & d | c & ~d | c & d; // 0011_1101_1101

    // ab = 01
    assign mux_in[1] = 0; // 0000_0000_0000

    // ab = 10
    assign mux_in[2] = ~c & ~d | c & d; // 1001_0001_1001

    // ab = 11
    assign mux_in[3] = ~d | c; // 1111_0011_1011

endmodule
