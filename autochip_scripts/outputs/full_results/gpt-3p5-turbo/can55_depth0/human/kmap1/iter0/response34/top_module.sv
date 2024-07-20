module top_module(
    input a, 
    input b,
    input c,
    output out
);

// Implement the truth table based on the given Karnaugh map
assign out = (a & ~b & c) | (a & b);

endmodule
