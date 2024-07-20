module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    // Using the Karnaugh map to derive the Boolean expression
    // Sum of minterms: (00 00), (00 01), (00 10), (01 00), (01 11), (10 00), (10 01), (11 01), (11 10), (11 11)
    // Min terms: m0, m1, m3, m4, m6, m8, m9, m10, m11, m13
    // Boolean expression in canonical form:
    // F = m0 + m1 + m3 + m4 + m6 + m8 + m9 + m10 + m11 + m13
    
    assign out = (~a & ~b & ~c & ~d) |  // m0
                 (~a & ~b & ~c &  d) |  // m1
                 (~a & ~b &  b &  d) |  // m3
                 (~a &  b & ~c & ~d) |  // m4
                 (~a &  b &  c &  d) |  // m6
                 ( a & ~b & ~c & ~d) |  // m8
                 ( a & ~b & ~c &  d) |  // m9
                 ( a & ~b &  c & ~d) |  // m10
                 ( a & ~b &  c &  d);   // m11
                 
endmodule
