module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map

    // ab = 00 -> mux_in[0]
    // cd   00 01 11 10
    //  00   0  0  0  1
    //  01   1  0  0  0
    //  11   1  0  1  1
    //  10   1  0  0  1
    assign mux_in[0] = (~c & d) | (c & ~d) | (c & d);

    // ab = 01 -> mux_in[1]
    // cd   00 01 11 10
    //  00   0  0  0  1
    //  01   1  0  0  0
    //  11   1  0  1  1
    //  10   1  0  0  1
    assign mux_in[1] = 0;

    // ab = 11 -> mux_in[3]
    // cd   00 01 11 10
    //  00   0  0  0  1
    //  01   1  0  0  0
    //  11   1  0  1  1
    //  10   1  0  0  1
    assign mux_in[3] = d;

    // ab = 10 -> mux_in[2]
    // cd   00 01 11 10
    //  00   0  0  0  1
    //  01   1  0  0  0
    //  11   1  0  1  1
    //  10   1  0  0  1
    assign mux_in[2] = d;

endmodule
