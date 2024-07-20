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
    always @* begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 0;
        endcase
    end
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire z_a1, z_b1, z_a2, z_b2;
    wire or_out, and_out;

    // Instantiate two A modules
    A A1 (.x(x), .y(y), .z(z_a1));
    A A2 (.x(x), .y(y), .z(z_a2));

    // Instantiate two B modules
    B B1 (.x(x), .y(y), .z(z_b1));
    B B2 (.x(x), .y(y), .z(z_b2));

    // OR gate for the first pair of A and B outputs
    assign or_out = z_a1 | z_b1;

    // AND gate for the second pair of A and B outputs
    assign and_out = z_a2 & z_b2;

    // XOR gate connecting OR and AND gate outputs
    assign z = or_out ^ and_out;
endmodule
