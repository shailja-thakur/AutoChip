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
            default: z = 1;
        endcase
    end
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire a1_z, a2_z;
    wire b1_z, b2_z;
    wire or_z, and_z;
    
    // Instantiate the first set of modules
    A a1 (.x(x), .y(y), .z(a1_z));
    B b1 (.x(x), .y(y), .z(b1_z));
    
    // Instantiate the second set of modules
    A a2 (.x(x), .y(y), .z(a2_z));
    B b2 (.x(x), .y(y), .z(b2_z));
    
    // OR gate
    assign or_z = a1_z | b1_z;
    
    // AND gate
    assign and_z = a2_z & b2_z;
    
    // XOR gate
    assign z = or_z ^ and_z;
    
endmodule
