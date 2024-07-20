module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    assign out[24] = ~(a ^ a); // Comparison between a and a
    assign out[23] = ~(a ^ b); // Comparison between a and b
    assign out[22] = ~(a ^ c); // Comparison between a and c
    assign out[21] = ~(a ^ d); // Comparison between a and d
    assign out[20] = ~(a ^ e); // Comparison between a and e
    assign out[19] = ~(b ^ a); // Comparison between b and a
    assign out[18] = ~(b ^ b); // Comparison between b and b
    assign out[17] = ~(b ^ c); // Comparison between b and c
    assign out[16] = ~(b ^ d); // Comparison between b and d
    assign out[15] = ~(b ^ e); // Comparison between b and e
    assign out[14] = ~(c ^ a); // Comparison between c and a
    assign out[13] = ~(c ^ b); // Comparison between c and b
    assign out[12] = ~(c ^ c); // Comparison between c and c
    assign out[11] = ~(c ^ d); // Comparison between c and d
    assign out[10] = ~(c ^ e); // Comparison between c and e
    assign out[9]  = ~(d ^ a); // Comparison between d and a
    assign out[8]  = ~(d ^ b); // Comparison between d and b
    assign out[7]  = ~(d ^ c); // Comparison between d and c
    assign out[6]  = ~(d ^ d); // Comparison between d and d
    assign out[5]  = ~(d ^ e); // Comparison between d and e
    assign out[4]  = ~(e ^ a); // Comparison between e and a
    assign out[3]  = ~(e ^ b); // Comparison between e and b
    assign out[2]  = ~(e ^ c); // Comparison between e and c
    assign out[1]  = ~(e ^ d); // Comparison between e and d
    assign out[0]  = ~(e ^ e); // Comparison between e and e

endmodule
