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
    always @ (x or y) begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 0;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire A1_out, B1_out, A2_out, B2_out, or_out, and_out;

    A A1 (
        .x(x),
        .y(y),
        .z(A1_out)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(B1_out)
    );

    A A2 (
        .x(x),
        .y(y),
        .z(A2_out)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(B2_out)
    );

    assign or_out = A1_out | B1_out;
    assign and_out = A2_out & B2_out;
    assign z = or_out ^ and_out;
endmodule
