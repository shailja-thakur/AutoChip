module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Use the Karnaugh map to create the truth table and derive the boolean expression.
    // From the Karnaugh map:
    //     ab
    // cd  00 01 11 10
    // 00  1  1  0  1
    // 01  1  0  0  1
    // 11  0  1  1  1
    // 10  1  1  0  0
    
    // Simplified expression from the given Karnaugh map:
    // out = (~a & ~b & ~c) | (~a & b & d) | (a & ~b & ~d) | (a & b & c)

    assign out = (~a & ~b & ~c) |
                 (~a & b & d)   |
                 (a & ~b & ~d)  |
                 (a & b & c);

endmodule
