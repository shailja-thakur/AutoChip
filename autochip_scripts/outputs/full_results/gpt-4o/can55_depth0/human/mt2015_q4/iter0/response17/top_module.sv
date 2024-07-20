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
    always @(x or y) begin
        case ({x, y})
            2'b00: z = 1'b1;
            2'b01: z = 1'b0;
            2'b10: z = 1'b0;
            2'b11: z = 1'b1;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire zOR, zAND;

    // Instantiate A and B submodules
    A u_A1 (.x(x), .y(y), .z(zA1));
    A u_A2 (.x(x), .y(y), .z(zA2));
    B u_B1 (.x(x), .y(y), .z(zB1));
    B u_B2 (.x(x), .y(y), .z(zB2));
    
    // OR gate for the first pair of A and B submodules
    assign zOR = zA1 | zB1;
    
    // AND gate for the second pair of A and B submodules
    assign zAND = zA2 & zB2;
    
    // XOR gate for the final output
    assign z = zOR ^ zAND;
endmodule
