module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // The Karnaugh map simplifies to: out = a | (b & c) | (~b & ~c)
    assign out = a | (b & c) | (~b & ~c);

endmodule
