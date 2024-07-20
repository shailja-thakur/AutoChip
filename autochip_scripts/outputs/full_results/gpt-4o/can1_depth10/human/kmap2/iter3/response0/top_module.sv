module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Use the Karnaugh map to create the truth table and derive the boolean expression.
    // Simplified expression from the given Karnaugh map:
    // out = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & b & c & d) |
    //       (a & ~b & ~c & ~d) | (a & ~b & c & d) | (a & b & ~c & ~d) |
    //       (a & b & ~c & d) | (a & b & c & d)

    assign out = (~a & ~b & ~c & d) |
                 (~a & ~b & c & d)  |
                 (~a & b & ~c & ~d) |
                 (~a & b & c & d)   |
                 (a & ~b & ~c & ~d) |
                 (a & ~b & c & d)   |
                 (a & b & ~c & ~d)  |
                 (a & b & ~c & d);

endmodule
