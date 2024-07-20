module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Revised simplified boolean expression based on the provided Karnaugh map:
    // From the Karnaugh map:
    //     ab
    // cd  00 01 11 10
    // 00  1  1  0  1
    // 01  1  0  0  1
    // 11  0  1  1  1
    // 10  1  1  0  0
    
    // The correct simplified expression is:
    // out = (~c & ~d) | (~b & ~d) | (a & b & c) | (~a & b & d)

    assign out = (~c & ~d) |
                 (~b & ~d) |
                 (a & b & c) |
                 (~a & b & d);

endmodule
