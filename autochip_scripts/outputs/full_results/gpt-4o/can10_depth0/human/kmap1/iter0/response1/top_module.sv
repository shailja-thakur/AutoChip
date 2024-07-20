module top_module(
    input a, 
    input b,
    input c,
    output out
);
    // Karnaugh map minimization results in the expression: out = b | a
    assign out = b | a;

endmodule
