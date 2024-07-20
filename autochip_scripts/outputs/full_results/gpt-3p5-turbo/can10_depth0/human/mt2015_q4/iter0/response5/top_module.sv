module A(
    input x,
    input y,
    output z);

    assign z = (x ^ y) & x;

endmodule
module B(
    input x,
    input y,
    output z);

    assign z = #(5) {(x ^ y) : x};

endmodule
module top_module(
    input x,
    input y,
    output z);

    A a1(.x(x), .y(y), .z(a1_z));
    A a2(.x(x), .y(y), .z(a2_z));
    B b1(.x(x), .y(y), .z(b1_z));
    B b2(.x(x), .y(y), .z(b2_z));

    wire a1_z, a2_z, b1_z, b2_z;

    assign z = a1_z ^ a2_z;

    or gate_or(
        .a(a1_z),
        .b(b1_z),
        .z(a1_z_or_b1_z)
    );

    and gate_and(
        .a(a2_z),
        .b(b2_z),
        .z(a2_z_and_b2_z)
    );

endmodule
module or(
    input a,
    input b,
    output z);

    assign z = a | b;

endmodule
module and(
    input a,
    input b,
    output z);

    assign z = a & b;

endmodule
module xor(
    input a,
    input b,
    output z);

    assign z = a ^ b;

endmodule
