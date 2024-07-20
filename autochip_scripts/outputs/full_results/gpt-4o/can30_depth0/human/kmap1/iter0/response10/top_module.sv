module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Based on the Karnaugh map, the boolean expression for 'out' is:
    // out = a | (b & !c)

    assign out = a | (b & !c);

endmodule
