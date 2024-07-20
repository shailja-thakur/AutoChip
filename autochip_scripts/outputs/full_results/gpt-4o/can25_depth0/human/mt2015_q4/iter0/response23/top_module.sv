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
        case({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 1;
        endcase
    end
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire a1_out, a2_out;
    wire b1_out, b2_out;
    wire or_out, and_out;

    // Instantiate the first A and B modules
    A a1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    // Instantiate the second A and B modules
    A a2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR gate for the first pair of A and B outputs
    assign or_out = a1_out | b1_out;

    // AND gate for the second pair of A and B outputs
    assign and_out = a2_out & b2_out;

    // XOR gate for the final output
    assign z = or_out ^ and_out;
endmodule
