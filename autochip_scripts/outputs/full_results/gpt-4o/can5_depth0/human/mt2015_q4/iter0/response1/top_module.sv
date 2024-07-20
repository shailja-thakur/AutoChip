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
            default: z = 1; // Covers all unexpected cases as default
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_result, and_result;

    A A1 (.x(x), .y(y), .z(zA1));
    A A2 (.x(x), .y(y), .z(zA2));
    B B1 (.x(x), .y(y), .z(zB1));
    B B2 (.x(x), .y(y), .z(zB2));

    assign or_result = zA1 | zB1;
    assign and_result = zA2 & zB2;
    assign z = or_result ^ and_result;
endmodule
