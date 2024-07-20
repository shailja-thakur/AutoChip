module top_module(
    input x,
    input y,
    output z
);

    wire a_intermediate;
    wire b_intermediate;

    // Assign x and y inputs to the appropriate gates
    assign a_intermediate = x;
    assign b_intermediate = y;

    // First gate
    gate1 gate1_instance(
        .a(a_intermediate),
        .b(b_intermediate),
        .out_a_third(a_third)
    );

    // Second gate
    gate2 gate2_instance(
        .a(b_intermediate),
        .b(a_intermediate),
        .out_b_third(b_third)
    );

    // Third gate
    gate3 gate3_instance(
        .a(a_third),
        .b(b_third),
        .z(z)
    );

endmodule
module gate1(
    input a,
    input b,
    output out_a_third
);
    // logic gate 1 implementation
    assign out_a_third = a;

endmodule
module gate2(
    input a,
    input b,
    output out_b_third
);
    // logic gate 2 implementation
    assign out_b_third = b;

endmodule
module gate3(
    input a,
    input b,
    output z
);
    // logic gate 3 implementation
    assign z = a & b;

endmodule
