module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // generated based on Karnaugh map
    assign out = (~a & ~b & ~c) | (~a & ~b & ~d) | (~a & c & d) | (~a & b & ~d) | 
                 (a & ~b & ~d) | (a & c & ~d) | (b & c & ~d) | (~b & c & ~d) | 
                 (a & b & c) | (~a & b & c);
endmodule
