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
            default: z = 0;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2;
    wire z_B1, z_B2;
    wire or_out, and_out;

    // Instantiate the first A and B submodules
    A A1 (.x(x), .y(y), .z(z_A1));
    B B1 (.x(x), .y(y), .z(z_B1));

    // Instantiate the second A and B submodules
    A A2 (.x(x), .y(y), .z(z_A2));
    B B2 (.x(x), .y(y), .z(z_B2));

    // OR gate for outputs of first A and B submodules
    assign or_out = z_A1 | z_B1;
    
    // AND gate for outputs of second A and B submodules
    assign and_out = z_A2 & z_B2;

    // XOR gate for outputs of OR and AND gates
    assign z = or_out ^ and_out;
endmodule
