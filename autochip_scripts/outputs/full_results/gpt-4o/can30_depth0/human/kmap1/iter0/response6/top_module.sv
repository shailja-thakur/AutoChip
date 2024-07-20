module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Karnaugh map derived Boolean expression: out = b + c
    assign out = b | c;

endmodule
