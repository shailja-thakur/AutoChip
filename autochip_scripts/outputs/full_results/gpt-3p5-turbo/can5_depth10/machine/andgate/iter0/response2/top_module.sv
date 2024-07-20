module top_module(
    input a,
    input b,
    output out
);

    // Declare a wire to represent the output of the logical AND operation
    wire and_output;

    // Implement the logical AND gate
    assign and_output = a & b;

    // Assign the output of the AND gate to the output port
    assign out = and_output;

endmodule
