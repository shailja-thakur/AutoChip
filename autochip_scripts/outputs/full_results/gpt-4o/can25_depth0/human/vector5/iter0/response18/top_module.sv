module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    assign out[24] = ~(a ^ a); // Comparing a with a
    assign out[23] = ~(a ^ b); // Comparing a with b
    assign out[22] = ~(a ^ c); // Comparing a with c
    assign out[21] = ~(a ^ d); // Comparing a with d
    assign out[20] = ~(a ^ e); // Comparing a with e

    assign out[19] = ~(b ^ a); // Comparing b with a
    assign out[18] = ~(b ^ b); // Comparing b with b
    assign out[17] = ~(b ^ c); // Comparing b with c
    assign out[16] = ~(b ^ d); // Comparing b with d
    assign out[15] = ~(b ^ e); // Comparing b with e

    assign out[14] = ~(c ^ a); // Comparing c with a
    assign out[13] = ~(c ^ b); // Comparing c with b
    assign out[12] = ~(c ^ c); // Comparing c with c
    assign out[11] = ~(c ^ d); // Comparing c with d
    assign out[10] = ~(c ^ e); // Comparing c with e

    assign out[ 9] = ~(d ^ a); // Comparing d with a
    assign out[ 8] = ~(d ^ b); // Comparing d with b
    assign out[ 7] = ~(d ^ c); // Comparing d with c
    assign out[ 6] = ~(d ^ d); // Comparing d with d
    assign out[ 5] = ~(d ^ e); // Comparing d with e

    assign out[ 4] = ~(e ^ a); // Comparing e with a
    assign out[ 3] = ~(e ^ b); // Comparing e with b
    assign out[ 2] = ~(e ^ c); // Comparing e with c
    assign out[ 1] = ~(e ^ d); // Comparing e with d
    assign out[ 0] = ~(e ^ e); // Comparing e with e

endmodule
