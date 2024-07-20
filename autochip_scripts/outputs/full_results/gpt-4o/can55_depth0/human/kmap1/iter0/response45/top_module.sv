module top_module(
    input a, 
    input b,
    input c,
    output out
);
    assign out = (~b & ~c & a) | (b & ~c) | (~b & c) | (b & c); // Simplified expression based on the Karnaugh map
endmodule
