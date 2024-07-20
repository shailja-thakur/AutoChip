module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map

    // ab = 00
    assign mux_in[0] = (~c & ~d);    // When cd = 00: Output is 0, cd = 01: Output is 1, cd = 10: Output is 1, cd = 11: Output is 1 => ~c & ~d

    // ab = 01
    assign mux_in[1] = (~c & d);     // When cd = 00: Output is 0, cd = 01: Output is 0, cd = 10: Output is 0, cd = 11: Output is 0 => ~c & d

    // ab = 10
    assign mux_in[2] = (c & ~d);     // When cd = 00: Output is 1, cd = 01: Output is 0, cd = 10: Output is 0, cd = 11: Output is 1 => c & ~d

    // ab = 11
    assign mux_in[3] = (c & d);      // When cd = 00: Output is 1, cd = 01: Output is 1, cd = 10: Output is 1, cd = 11: Output is 1 => c & d
    
endmodule
