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
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2, z_B1, z_B2;
    wire or_out, and_out;
    
    // Instantiate two A submodules
    A A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );
    
    A A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );

    // Instantiate two B submodules
    B B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );
    
    // OR gate for the outputs of the first A and B submodules
    assign or_out = z_A1 | z_B1;
    
    // AND gate for the outputs of the second A and B submodules
    assign and_out = z_A2 & z_B2;
    
    // XOR gate for the outputs of the OR and AND gates
    assign z = or_out ^ and_out;
endmodule
