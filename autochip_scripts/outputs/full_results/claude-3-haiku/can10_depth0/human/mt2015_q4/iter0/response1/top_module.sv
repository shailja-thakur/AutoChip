module module_A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module module_B (
    input x,
    input y,
    output z
);
    assign z = ~((x & ~y) | (~x & y));
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z1, z2;

    // First pair of A and B submodules
    module_A a1 (
        .x(x),
        .y(y),
        .z(z1)
    );
    module_B b1 (
        .x(x),
        .y(y),
        .z(z1)
    );

    // Second pair of A and B submodules
    module_A a2 (
        .x(x),
        .y(y),
        .z(z2)
    );
    module_B b2 (
        .x(x),
        .y(y),
        .z(z2)
    );

    // Connect the outputs of the submodules
    assign z = (z1 | z2) ^ (z1 & z2);
endmodule
