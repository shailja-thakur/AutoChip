module top_module(
    input a,
    input b,
    input c,
    output out
);

// Karnaugh map analysis:
// Simplified expression from K-map: out = b | c | a

assign out = b | c | a;

endmodule
