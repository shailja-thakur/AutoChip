module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // Pairwise comparisons in the 25-bit output vector
    assign out[24] = ~(a ^ a); // compare a with a
    assign out[23] = ~(a ^ b); // compare a with b
    assign out[22] = ~(a ^ c); // compare a with c
    assign out[21] = ~(a ^ d); // compare a with d
    assign out[20] = ~(a ^ e); // compare a with e

    assign out[19] = ~(b ^ a); // compare b with a
    assign out[18] = ~(b ^ b); // compare b with b
    assign out[17] = ~(b ^ c); // compare b with c
    assign out[16] = ~(b ^ d); // compare b with d
    assign out[15] = ~(b ^ e); // compare b with e

    assign out[14] = ~(c ^ a); // compare c with a
    assign out[13] = ~(c ^ b); // compare c with b
    assign out[12] = ~(c ^ c); // compare c with c
    assign out[11] = ~(c ^ d); // compare c with d
    assign out[10] = ~(c ^ e); // compare c with e

    assign out[9]  = ~(d ^ a); // compare d with a
    assign out[8]  = ~(d ^ b); // compare d with b
    assign out[7]  = ~(d ^ c); // compare d with c
    assign out[6]  = ~(d ^ d); // compare d with d
    assign out[5]  = ~(d ^ e); // compare d with e

    assign out[4]  = ~(e ^ a); // compare e with a
    assign out[3]  = ~(e ^ b); // compare e with b
    assign out[2]  = ~(e ^ c); // compare e with c
    assign out[1]  = ~(e ^ d); // compare e with d
    assign out[0]  = ~(e ^ e); // compare e with e

endmodule
