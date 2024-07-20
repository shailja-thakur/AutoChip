module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Karnaugh map simplified function: out = a | b
    assign out = a | b;

endmodule
