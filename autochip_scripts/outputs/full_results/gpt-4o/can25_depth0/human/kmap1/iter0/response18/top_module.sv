module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Implementing the Karnaugh map described logic
    assign out = (~b & ~c & a) | (b & c) | (~b & c) | (b & ~c);

endmodule
