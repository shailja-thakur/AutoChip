module top_module(
    input a, 
    input b,
    input c,
    output out
);

    assign out = (~b & c) | (b & ~c) | (b & c) | (a); // Simplified expression of K-map: a + bc

endmodule
