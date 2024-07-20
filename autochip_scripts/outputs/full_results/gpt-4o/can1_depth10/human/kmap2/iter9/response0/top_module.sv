module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // From the Karnaugh map:
    //     ab
    // cd  00 01 11 10
    // 00  1  1  0  1
    // 01  1  0  0  1
    // 11  0  1  1  1
    // 10  1  1  0  0
    
    // The correct minimized boolean expression can be derived:
    // out = (~a & ~b & ~d) | (~a & c & ~d) | (b & c & ~d) | (b & c & d)

    assign out = (~a & ~b & ~d) | 
                 (~a & c & ~d) | 
                 (b & c & ~d) | 
                 (b & c & d);

endmodule
