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
    always @(x, y) begin
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
    wire zA1, zA2, zB1, zB2;
    wire or_out, and_out;
    
    // Instantiate the A and B submodules
    A subA1 (.x(x), .y(y), .z(zA1));
    A subA2 (.x(x), .y(y), .z(zA2));
    B subB1 (.x(x), .y(y), .z(zB1));
    B subB2 (.x(x), .y(y), .z(zB2));

    // OR gate for the first pair
    assign or_out = zA1 | zB1;

    // AND gate for the second pair
    assign and_out = zA2 & zB2;

    // XOR gate for the final output
    assign z = or_out ^ and_out;
endmodule
