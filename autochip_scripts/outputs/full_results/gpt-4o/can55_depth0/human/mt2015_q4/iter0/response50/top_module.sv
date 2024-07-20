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
            default: z = 1'bx;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z1_a, z1_b, z2_a, z2_b;
    wire or_out, and_out;
    
    // Instantiating the first pair of A and B submodules
    A a1 (
        .x(x),
        .y(y),
        .z(z1_a)
    );
    
    B b1 (
        .x(x),
        .y(y),
        .z(z1_b)
    );
    
    // Instantiating the second pair of A and B submodules
    A a2 (
        .x(x),
        .y(y),
        .z(z2_a)
    );
    
    B b2 (
        .x(x),
        .y(y),
        .z(z2_b)
    );
    
    // OR gate for the first pair
    assign or_out = z1_a | z1_b;
    
    // AND gate for the second pair
    assign and_out = z2_a & z2_b;
    
    // XOR gate to produce the final output
    assign z = or_out ^ and_out;
endmodule
