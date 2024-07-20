module top_module(
    input a, 
    input b,
    output out
);

    // The logic for the module is as follows:
    // The output 'out' should be the logical negation of the logical OR of the two inputs 'a' and 'b'
    // This can be achieved by using a NOR gate, which performs the OR operation and then inverts the result

    assign out = ~(a | b);

endmodule
