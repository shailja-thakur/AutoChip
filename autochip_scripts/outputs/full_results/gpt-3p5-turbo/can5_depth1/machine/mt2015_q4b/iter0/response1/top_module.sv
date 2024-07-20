module top_module(
    input x,
    input y,
    output z);

    // Define internal wires or variables here if needed

    // Logical negation of the exclusive-or (XOR) of the two inputs
    assign z = ~(x ^ y);

endmodule
