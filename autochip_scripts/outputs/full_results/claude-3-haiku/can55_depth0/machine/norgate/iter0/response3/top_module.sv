module top_module(
    input a, 
    input b,
    output out
);

// The output should be the logical negation of the logical OR of the two inputs
assign out = ~(a | b);

endmodule
