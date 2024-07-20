module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Use the Karnaugh map to derive the logic equation for out
    assign out = (b & c) | (~b & c) | (b & ~c) | (~b & ~c & a);

endmodule
