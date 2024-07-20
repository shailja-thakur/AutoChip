module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Use a combination of c and d to generate mux inputs as per the K-map
    // K-map:
    //  cd
    // ab   00   01   11   10
    // 00 | 0 | 0 | 0 | 1 |
    // 01 | 1 | 0 | 0 | 0 |
    // 11 | 1 | 0 | 1 | 1 |
    // 10 | 1 | 0 | 0 | 1 |

    // Assign values to mux_in based on the K-map
    assign mux_in[0] = (~c & ~d); // ab = 00
    assign mux_in[1] = (c & ~d);  // ab = 01
    assign mux_in[2] = (c & d);   // ab = 11
    assign mux_in[3] = (~c & d);  // ab = 10

endmodule
