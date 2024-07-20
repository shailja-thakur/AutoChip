module top_module(
    input a,
    input b,
    output out
);

    // The logic for the module is as follows:
    // The output 'out' should be the logical negation of the logical OR of the two inputs 'a' and 'b'
    // This can be implemented using a NOR gate

    wire or_out;

    // Implement the OR gate
    assign or_out = a | b;

    // Implement the inverter
    assign out = ~or_out;

endmodule
