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
    reg [2:0] state;
    always @(*) begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 1;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zB1, zA2, zB2;
    wire or_output, and_output;

    // Instantiate 1st A submodule
    A inst_A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    // Instantiate 1st B submodule
    B inst_B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    // Instantiate 2nd A submodule
    A inst_A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    // Instantiate 2nd B submodule
    B inst_B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    // OR gate for the first pair of submodules' outputs
    assign or_output = zA1 | zB1;

    // AND gate for the second pair of submodules' outputs
    assign and_output = zA2 & zB2;

    // XOR gate for the OR and AND gates' outputs
    assign z = or_output ^ and_output;
endmodule
