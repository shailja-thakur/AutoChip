module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // K-map:
    //       ab
    // cd   00 01 11 10
    //  00 | 0 | 0 | 0 | 1 |
    //  01 | 1 | 0 | 0 | 0 |
    //  11 | 1 | 0 | 1 | 1 |
    //  10 | 1 | 0 | 0 | 1 |

    // Assign mux_in based on the K-map
    assign mux_in[0] = (c & d) | (~c & d) | (c & ~d); // 00 case for cd
    assign mux_in[1] = 1'b0; // 01 case for cd
    assign mux_in[2] = (c & d); // 11 case for cd
    assign mux_in[3] = (d | ~c); // 10 case for cd

endmodule
