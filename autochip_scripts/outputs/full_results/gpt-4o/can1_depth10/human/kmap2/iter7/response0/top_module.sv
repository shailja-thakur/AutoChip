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
    // Minterms m0, m1, m3, m4, m7, m9, m10, m11, m14

    assign out = (~c & ~d) |            // m0, m1, m4
                 (~a & ~b & d) |        // m3
                 (b & d) |             // m7, m11, m15
                 (a & c & d) |          // m11
                 (a & b & ~d);          // m13
endmodule
