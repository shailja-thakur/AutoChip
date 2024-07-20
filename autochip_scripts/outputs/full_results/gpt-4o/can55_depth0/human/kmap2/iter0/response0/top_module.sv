module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // Boolean equation derived from the Karnaugh map
    assign out = (~a & ~b & ~c & ~d) | (~a & b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & ~b & ~c & d) |
                 (a & b & ~c & d) | (a & ~b & ~c & ~d) | (~a & b & c & d) |
                 (a & b & c & ~d) | (~a & b & c & ~d) | (a & b & c & d);
endmodule
