module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // mux_in mapping based on the Karnaugh map
    // ab  00  01  11  10
    // cd  -------------
    // 00 | 0 | 0 | 0 | 1 |
    // 01 | 1 | 0 | 0 | 0 |
    // 11 | 1 | 0 | 1 | 1 |
    // 10 | 1 | 0 | 0 | 1 |

    assign mux_in[0] = (~c & ~d & 1'b0) |
                       ( c & ~d & 1'b1) |
                       ( c &  d & 1'b1) |
                       (~c &  d & 1'b1);

    assign mux_in[1] = 1'b0; // ab = 01, entire column is 0
    assign mux_in[2] = ( c & d); // ab = 11, only true for cd = 11
    assign mux_in[3] = (~c & ~d) |
                       ( c & ~d & 1'b1) |
                       ( c &  d & 1'b1) |
                       (~c &  d & 1'b0);

endmodule
