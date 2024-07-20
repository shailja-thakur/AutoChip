module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // According to the Karnaugh map provided:
    // mux_in[0] (ab = 00) corresponds to the expression: ~c~d + c~d + cd + ~cd = d + c
    assign mux_in[0] = d | c;

    // mux_in[1] (ab = 01) corresponds to the expression: 0 (always 0)
    assign mux_in[1] = 0;

    // mux_in[2] (ab = 11) corresponds to the expression: cd
    assign mux_in[2] = c & d;

    // mux_in[3] (ab = 10) corresponds to the expression: ~c~d + cd = c ^ d (XOR)
    assign mux_in[3] = c ^ d;

endmodule
