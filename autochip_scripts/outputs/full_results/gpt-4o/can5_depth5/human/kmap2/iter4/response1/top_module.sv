module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Creating sum of minterms for Karnaugh map
    assign out = (~c & ~d) | (~a & ~b & ~c) | (~a & ~b & d) | (~a & b & c & ~d) | (a & ~b & ~c & ~d) | (a & b & c) | (a & b & d);

endmodule
