module top_module(
    input a, 
    input b,
    output out
);

    // The logical negation of the logical OR of the two inputs
    assign out = ~(a | b);

endmodule
