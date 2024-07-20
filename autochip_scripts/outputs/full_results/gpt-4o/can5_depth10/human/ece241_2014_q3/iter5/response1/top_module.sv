module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values according to the provided Karnaugh map:
    // cd\ab - 00   01   11   10
    //  00 |  0 |  0 |  0 |  1 |
    //  01 |  1 |  0 |  0 |  0 |
    //  11 |  1 |  0 |  1 |  1 |
    //  10 |  1 |  0 |  0 |  1 |

    // ab = 00
    assign mux_in[0] = (~c & d) | (c & ~d) | (c & d); // 00=0, 01=1, 11=1, 10=1 => 1 when cd= 01/11/10 otherwise 0

    // ab = 01
    assign mux_in[1] = 0;  // All values are 0

    // ab = 10
    assign mux_in[2] = (~c & ~d) | (c & d); // 00=1, 01=0, 11=1, 10=1 => 1 when cd=00/11/10 otherwise 0

    // ab = 11
    assign mux_in[3] = (c & d) | (~c & ~d); // 00=1, 01=0, 11=1, 10=1 => 1 when cd=00/11/10 otherwise 0

endmodule
