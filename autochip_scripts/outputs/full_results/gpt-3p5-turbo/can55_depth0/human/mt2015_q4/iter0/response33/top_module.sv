module A(input x, input y, output z);
    assign z = (x ^ y) & x;
endmodule
module B(input x, input y, output z);
    always @(*)
        case({x, y})
            2'b00: z = 1'b1;
            2'b01: z = 1'b0;
            2'b10: z = 1'b0;
            2'b11: z = 1'b1;
        endcase
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1_z, a2_z, b1_z, b2_z;
    A a1(.x(x), .y(y), .z(a1_z));
    A a2(.x(x), .y(y), .z(a2_z));
    B b1(.x(x), .y(y), .z(b1_z));
    B b2(.x(x), .y(y), .z(b2_z));
    
    assign z = a1_z ^ a2_z ^ b1_z & b2_z;
    
endmodule
