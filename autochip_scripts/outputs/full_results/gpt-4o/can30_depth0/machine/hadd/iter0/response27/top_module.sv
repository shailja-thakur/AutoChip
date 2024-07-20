module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    // Internal wires to hold intermediate sum and carry
    wire sum_internal;
    wire carry_internal;

    // Sum calculation
    assign sum_internal = a ^ b;

    // Carry calculation
    assign carry_internal = a & b;

    // Assign the results to the outputs
    assign sum = sum_internal;
    assign cout = carry_internal;

endmodule
