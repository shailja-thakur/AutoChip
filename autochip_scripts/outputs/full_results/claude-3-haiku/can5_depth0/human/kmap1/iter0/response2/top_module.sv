module top_module(
    input a, 
    input b,
    input c,
    output out
);

// The given Karnaugh map indicates that the output `out` should be 1 whenever
// any of the input combinations (a, b, c) are (0, 1, x) or (1, x, x).
// This can be expressed using the OR of the two minterms:

assign out = (~a & b) | (a);

endmodule
