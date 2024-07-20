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
            default: z = 1; // default case to maintain consistency
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zB1, zA2, zB2;
    wire or_out, and_out;
    
    A A1(.x(x), .y(y), .z(zA1));   // First A submodule
    B B1(.x(x), .y(y), .z(zB1));   // First B submodule
    A A2(.x(x), .y(y), .z(zA2));   // Second A submodule
    B B2(.x(x), .y(y), .z(zB2));   // Second B submodule
    
    assign or_out = zA1 | zB1;    // OR gate
    assign and_out = zA2 & zB2;   // AND gate
    
    assign z = or_out ^ and_out;  // XOR gate

endmodule
