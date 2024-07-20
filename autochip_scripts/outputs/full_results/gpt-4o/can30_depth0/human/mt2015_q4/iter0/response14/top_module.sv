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
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 1'bx;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2, z_B1, z_B2;
    wire or_output;
    wire and_output;

    // Instantiate the first A module
    A A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );

    // Instantiate the first B module
    B B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );

    // OR gate for the first pair of A and B modules
    assign or_output = z_A1 | z_B1;

    // Instantiate the second A module
    A A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );

    // Instantiate the second B module
    B B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );

    // AND gate for the second pair of A and B modules
    assign and_output = z_A2 & z_B2;

    // XOR gate for the output
    assign z = or_output ^ and_output;
endmodule
