module A(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B(
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
            default: z = 0;
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

    // Instantiate the first A and B submodules
    A a1(.x(x), .y(y), .z(zA1));
    B b1(.x(x), .y(y), .z(zB1));

    // Instantiate the second A and B submodules
    A a2(.x(x), .y(y), .z(zA2));
    B b2(.x(x), .y(y), .z(zB2));

    // Logic: OR gate with outputs of first A and B submodules
    assign or_output = zA1 | zB1;

    // Logic: AND gate with outputs of second A and B submodules
    assign and_output = zA2 & zB2;

    // Logic: XOR gate with the outputs of the OR and AND gates
    assign z = or_output ^ and_output;
endmodule
