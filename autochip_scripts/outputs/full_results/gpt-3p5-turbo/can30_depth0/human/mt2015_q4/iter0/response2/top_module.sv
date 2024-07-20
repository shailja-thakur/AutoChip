module A(
    input x,
    input y,
    output z
);

    assign z = (x ^ y) & x;

endmodule
module B(
    input x,
    input y,
    output z
);

    reg z;

    always @(*)
    begin
        case({x, y})
            2'b00: z = 1'b1;
            2'b01: z = 1'b0;
            2'b10: z = 1'b0;
            2'b11: z = 1'b1;
        endcase
    end

endmodule
module top_module(
    input x,
    input y,
    output z
);

    wire a1_z, a2_z, b1_z, b2_z;

    A a1(.x(x), .y(y), .z(a1_z));
    A a2(.x(x), .y(y), .z(a2_z));
    B b1(.x(x), .y(y), .z(b1_z));
    B b2(.x(x), .y(y), .z(b2_z));

    or or_gate(
        .a(a1_z),
        .b(b1_z),
        .z(z)
    );

    and and_gate(
        .a(a2_z),
        .b(b2_z),
        .z(z)
    );

    xor xor_gate(
        .a(or_gate),
        .b(and_gate),
        .z(z)
    );

endmodule
