module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implement the Karnaugh map logic:
    // ab
    // cd   00 01 11 10
    //  00 | 0 | 0 | 0 | 1 |
    //  01 | 1 | 0 | 0 | 0 |
    //  11 | 1 | 0 | 1 | 1 |
    //  10 | 1 | 0 | 0 | 1 |

    // Assign values to mux_in based on the K-map
    assign mux_in[0] = (~c & ~d) | (c & d); // ab = 00: mux_in[0] = K-map values 1, 2, 3, 4
    assign mux_in[1] = 0;                  // ab = 01: always 0
    assign mux_in[2] = (c & d) | (~c & d); // ab = 11: mux_in[2] = K-map values 7, 11, 15
    assign mux_in[3] = (~c & d) | (~d & c); // ab = 10: mux_in[3] = K-map values 8, 9, 14

endmodule
