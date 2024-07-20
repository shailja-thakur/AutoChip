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
        if (x === 1'b0 && y === 1'b0)
            z = 1;
        else if (x === 1'b0 && y === 1'b1)
            z = 0;
        else if (x === 1'b1 && y === 1'b0)
            z = 0;
        else if (x === 1'b1 && y === 1'b1)
            z = 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2, z_B1, z_B2;
    wire or_output, and_output;

    // Instantiate the first A and B submodules
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

    // OR gate for the outputs of the first A and B submodules
    assign or_output = z_A1 | z_B1;

    // Instantiate the second A and B submodules
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

    // AND gate for the outputs of the second A and B submodules
    assign and_output = z_A2 & z_B2;

    // XOR gate for the outputs of the OR and AND
    assign z = or_output ^ and_output;
endmodule
