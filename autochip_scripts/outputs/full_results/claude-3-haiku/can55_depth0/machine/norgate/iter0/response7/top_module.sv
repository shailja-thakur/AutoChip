module top_module(
    input a,
    input b,
    output out
);

    // The output 'out' should be the logical negation of the logical OR of the two inputs 'a' and 'b'
    assign out = ~(a | b);

endmodule
