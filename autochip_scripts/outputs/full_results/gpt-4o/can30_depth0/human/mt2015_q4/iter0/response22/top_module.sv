module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input x,
    input y,
    output reg z
);
    always @(*)
    begin
        if ((x == 1 && y == 1) || (x == 0 && y == 0))
            z = 1;
        else
            z = 0;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z1_A, z1_B, z2_A, z2_B;
    wire or_out, and_out;

    // Instances of Module A
    A A1(
        .x(x),
        .y(y),
        .z(z1_A)
    );

    A A2(
        .x(x),
        .y(y),
        .z(z2_A)
    );

    // Instances of Module B
    B B1(
        .x(x),
        .y(y),
        .z(z1_B)
    );

    B B2(
        .x(x),
        .y(y),
        .z(z2_B)
    );

    // OR gate
    assign or_out = z1_A | z1_B;

    // AND gate
    assign and_out = z2_A & z2_B;

    // XOR gate
    assign z = or_out ^ and_out;

endmodule
