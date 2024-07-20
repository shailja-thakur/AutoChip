module top_module(
    input a,
    input b,
    input c,
    output out
);

    // Simplified expression from the Karnaugh map: out = b'c'a + bc'a + bca + b'ca + b'c'a'
    assign out = (~b & ~c & a) | (b & ~c & a) | (b & c & a) | (~b & c & a) | ( b & ~c);

endmodule
