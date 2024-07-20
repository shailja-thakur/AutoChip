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
    output z
    );
    
    always @(*)
    begin
        case({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase
    end
    
endmodule
module top_module(
    input x,
    input y,
    output z
    );
    
    wire z1, z2;
    wire z_or, z_and;
    
    A a1(x, y, z1);
    A a2(x, y, z2);
    B b1(x, y, z_or);
    B b2(x, y, z_and);
    
    assign z = z_or ^ z_and;
    
endmodule
