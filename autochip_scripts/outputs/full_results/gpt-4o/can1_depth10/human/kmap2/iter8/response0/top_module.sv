module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // From the Karnaugh map, produce the correct simplified boolean expression:
    //     ab
    // cd  00 01 11 10
    // 00  1  1  0  1
    // 01  1  0  0  1
    // 11  0  1  1  1
    // 10  1  1  0  0
    
    // We should generate the correct SOP (Sum of Products) from the K-map:
    // Minterms: m0, m1, m3, m4, m7, m8, m10, m11, m14

    assign out = (~a & ~b & ~c & ~d) | // m0
                 (~a & ~b & ~c & d)  | // m1
                 (~a & ~b & d & ~c)  | // m3
                 (~a & b & ~c & ~d)  | // m4
                 (~a & b & d & ~c)   | // m7
                 (a & ~b & c & ~d)   | // m8
                 (a & ~b & c & d)    | // m10
                 (a & b & c & ~d)    | // m11
                 (a & b & ~c & d);     // m14

endmodule
