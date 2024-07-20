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
        endcase
    end
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire z_A1, z_A2, z_B1, z_B2;
    wire or_out, and_out;
    
    // Instantiate modules A and B
    A A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );
    
    B B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );
    
    A A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );
    
    B B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );
    
    // OR gate for the first pair of A and B modules
    assign or_out = z_A1 | z_B1;
    
    // AND gate for the second pair of A and B modules
    assign and_out = z_A2 & z_B2;
    
    // XOR gate combining the outputs of the OR and AND gates
    assign z = or_out ^ and_out;
endmodule
