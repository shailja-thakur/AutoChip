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
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 0; // default case
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire a1_out, a2_out;
    wire b1_out, b2_out;
    wire or_out, and_out;

    // Instantiate two A submodules
    A a1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );
    A a2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    // Instantiate two B submodules
    B b1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );
    B b2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // Connect outputs of the first A and B submodules to an OR gate
    assign or_out = a1_out | b1_out;

    // Connect outputs of the second A and B submodules to an AND gate
    assign and_out = a2_out & b2_out;

    // Connect the outputs of the OR and AND gates to an XOR gate
    assign z = or_out ^ and_out;
endmodule
