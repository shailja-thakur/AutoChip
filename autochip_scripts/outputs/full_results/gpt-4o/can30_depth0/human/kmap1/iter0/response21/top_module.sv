module top_module(
    input a, 
    input b,
    input c,
    output out
);
    // Sum of minterms from the Karnaugh map
    assign out = (~b & ~c & a) | (~b & c) | (b & a) | (b & ~a & c);
endmodule
