module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Filling the truth table directly based on the K-map
    // mux_in[ab] when cd
    // cd\ab       00      01     11     10
    //  00 | 0 =  mux_in[0]  | 0 = mux_in[1]  | 0 = mux_in[2]  | 1 = mux_in[3]  |
    //  01 | 1 =  mux_in[0]  | 0 = mux_in[1]  | 0 = mux_in[2]  | 0 = mux_in[3]  |
    //  11 | 1 =  mux_in[0]  | 0 = mux_in[1]  | 1 = mux_in[2]  | 1 = mux_in[3]  |
    //  10 | 1 =  mux_in[0]  | 0 = mux_in[1]  | 0 = mux_in[2]  | 1 = mux_in[3]  |

    assign mux_in[0] = ( (~c) & (~d) & 1'b0 ) | ( (~c) & (d) & 1'b1 ) | ( (c) & (~d) & 1'b1 ) | ( (c) & (d) & 1'b1 );
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = (c & d);
    assign mux_in[3] = ( (~c) & (~d) & 1'b1 ) | ( (~c) & (d) & 1'b0 ) | ( (c) & (~d) & 1'b1 ) | ( (c) & (d) & 1'b1 );

endmodule
