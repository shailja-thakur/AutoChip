module top_module(
    input wire x,
    input wire y,
    output wire z
);

    wire a1_z, a2_z, b1_z, b2_z, or_out, and_out;
    
    A a1 (
        .x(x),
        .y(y),
        .z(a1_z)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(b1_z)
    );

    A a2 (
        .x(x),
        .y(y),
        .z(a2_z)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(b2_z)
    );

    or or_gate (
        .a(a1_z),
        .b(b1_z),
        .z(or_out)
    );

    and and_gate (
        .a(a2_z),
        .b(b2_z),
        .z(and_out)
    );

    xor xor_gate (
        .a(or_out),
        .b(and_out),
        .z(z)
    );

endmodule
