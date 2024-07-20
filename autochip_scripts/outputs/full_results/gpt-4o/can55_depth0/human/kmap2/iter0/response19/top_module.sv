module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Simplified Boolean expression from the Karnaugh map
    assign out = (~c & ~d) | (~a & ~b & d) | (a & b & ~d) | (b & d) | (a & ~b & c);

endmodule
