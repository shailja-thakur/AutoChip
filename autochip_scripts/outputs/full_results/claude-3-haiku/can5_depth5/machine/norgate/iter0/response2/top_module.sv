module top_module(
    input a,
    input b,
    output out
);

    // The logic for the module is as follows:
    // The output should be the logical negation of the logical OR of the two inputs
    // This can be achieved by using the NOR gate, which performs the OR operation and then inverts the result

    assign out = ~(a | b);

endmodule
