module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    assign out[24] = ~(a ^ a); // (a == a)
    assign out[23] = ~(a ^ b); // (a == b)
    assign out[22] = ~(a ^ c); // (a == c)
    assign out[21] = ~(a ^ d); // (a == d)
    assign out[20] = ~(a ^ e); // (a == e)

    assign out[19] = ~(b ^ a); // (b == a)
    assign out[18] = ~(b ^ b); // (b == b)
    assign out[17] = ~(b ^ c); // (b == c)
    assign out[16] = ~(b ^ d); // (b == d)
    assign out[15] = ~(b ^ e); // (b == e)

    assign out[14] = ~(c ^ a); // (c == a)
    assign out[13] = ~(c ^ b); // (c == b)
    assign out[12] = ~(c ^ c); // (c == c)
    assign out[11] = ~(c ^ d); // (c == d)
    assign out[10] = ~(c ^ e); // (c == e)

    assign out[ 9] = ~(d ^ a); // (d == a)
    assign out[ 8] = ~(d ^ b); // (d == b)
    assign out[ 7] = ~(d ^ c); // (d == c)
    assign out[ 6] = ~(d ^ d); // (d == d)
    assign out[ 5] = ~(d ^ e); // (d == e)

    assign out[ 4] = ~(e ^ a); // (e == a)
    assign out[ 3] = ~(e ^ b); // (e == b)
    assign out[ 2] = ~(e ^ c); // (e == c)
    assign out[ 1] = ~(e ^ d); // (e == d)
    assign out[ 0] = ~(e ^ e); // (e == e)

endmodule
