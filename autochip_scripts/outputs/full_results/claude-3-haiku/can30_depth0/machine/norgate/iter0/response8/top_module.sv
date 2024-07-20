module top_module(
    input a, 
    input b,
    output out
);

    // The logic for the module is as follows:
    // The output 'out' should be the logical negation of the logical OR of the two inputs 'a' and 'b'.
    // This can be implemented using a NOR gate.

    assign out = ~(a | b);

endmodule
