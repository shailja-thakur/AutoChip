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
    always @(*) begin
        case ({x,y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 1; // default case for handling X's or Z's
        endcase
    end
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire z1_a, z1_b, z2_a, z2_b;
    wire z_or, z_and;

    // Instantiate the first A and B submodules
    A a1 (
        .x(x),
        .y(y),
        .z(z1_a)
    );
    B b1 (
        .x(x),
        .y(y),
        .z(z1_b)
    );

    // OR gate for first pair
    assign z_or = z1_a | z1_b;

    // Instantiate the second A and B submodules
    A a2 (
        .x(x),
        .y(y),
        .z(z2_a)
    );
    B b2 (
        .x(x),
        .y(y),
        .z(z2_b)
    );

    // AND gate for second pair
    assign z_and = z2_a & z2_b;

    // XOR gate for final output
    assign z = z_or ^ z_and;
endmodule
