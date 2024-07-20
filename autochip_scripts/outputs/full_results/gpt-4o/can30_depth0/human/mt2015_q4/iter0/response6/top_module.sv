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
            default: z = 1'bx;  // unspecified state, should not happen
        endcase
    end
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_output, and_output;

    // Instantiate the A modules
    A A1 (.x(x), .y(y), .z(zA1));
    A A2 (.x(x), .y(y), .z(zA2));

    // Instantiate the B modules
    B B1 (.x(x), .y(y), .z(zB1));
    B B2 (.x(x), .y(y), .z(zB2));

    // OR gate for the first pair of A and B
    assign or_output = zA1 | zB1;

    // AND gate for the second pair of A and B
    assign and_output = zA2 & zB2;

    // XOR gate for the final output
    assign z = or_output ^ and_output;
endmodule
