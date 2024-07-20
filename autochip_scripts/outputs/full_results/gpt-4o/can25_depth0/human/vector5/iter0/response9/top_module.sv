module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    assign out[24] = ~(a ^ a);
    assign out[23] = ~(a ^ b);
    assign out[22] = ~(a ^ c);
    assign out[21] = ~(a ^ d);
    assign out[20] = ~(a ^ e);
    assign out[19] = ~(b ^ a); // This is effectively the same as out[23]
    assign out[18] = ~(b ^ b);
    assign out[17] = ~(b ^ c);
    assign out[16] = ~(b ^ d);
    assign out[15] = ~(b ^ e);
    assign out[14] = ~(c ^ a); // This is effectively the same as out[22]
    assign out[13] = ~(c ^ b); // This is effectively the same as out[17]
    assign out[12] = ~(c ^ c);
    assign out[11] = ~(c ^ d);
    assign out[10] = ~(c ^ e);
    assign out[ 9] = ~(d ^ a); // This is effectively the same as out[21]
    assign out[ 8] = ~(d ^ b); // This is effectively the same as out[16]
    assign out[ 7] = ~(d ^ c); // This is effectively the same as out[11]
    assign out[ 6] = ~(d ^ d);
    assign out[ 5] = ~(d ^ e);
    assign out[ 4] = ~(e ^ a); // This is effectively the same as out[20]
    assign out[ 3] = ~(e ^ b); // This is effectively the same as out[15]
    assign out[ 2] = ~(e ^ c); // This is effectively the same as out[10]
    assign out[ 1] = ~(e ^ d); // This is effectively the same as out[ 5]
    assign out[ 0] = ~(e ^ e);

endmodule
