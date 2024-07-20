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
    output z
);
    reg z_reg;

    always @(*) begin
        if (x == 1'b0 && y == 1'b0)
            z_reg = 1'b1;
        else if (x == 1'b1 && y == 1'b0)
            z_reg = 1'b0;
        else if (x == 1'b0 && y == 1'b1)
            z_reg = 1'b0;
        else if (x == 1'b1 && y == 1'b1)
            z_reg = 1'b1;
    end

    assign z = z_reg;
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2, z_B1, z_B2;
    wire or_output, and_output;

    A A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );

    assign or_output = z_A1 | z_B1;

    A A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );

    assign and_output = z_A2 & z_B2;

    assign z = or_output ^ and_output;
endmodule
