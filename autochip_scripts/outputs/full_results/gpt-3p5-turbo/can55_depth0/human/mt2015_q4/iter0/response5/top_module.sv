module A(
    input x,
    input y,
    output z);
    
    assign z = (x ^ y) & x;
    
endmodule
module B(
    input x,
    input y,
    output z);
    
    always @(x or y)
    begin
        case({x,y})
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
    output z);
    
    A a1(
        .x(x),
        .y(y),
        .z(w1)
    );
    
    B b1(
        .x(x),
        .y(y),
        .z(w2)
    );
    
    A a2(
        .x(x),
        .y(y),
        .z(w3)
    );
    
    B b2(
        .x(x),
        .y(y),
        .z(w4)
    );
    
    or or_gate(
        .a(w1),
        .b(w2),
        .z(w5)
    );
    
    and and_gate(
        .a(w3),
        .b(w4),
        .z(w6)
    );
    
    xor xor_gate(
        .a(w5),
        .b(w6),
        .z(z)
    );
    
    wire w1, w2, w3, w4, w5, w6;
    
endmodule
