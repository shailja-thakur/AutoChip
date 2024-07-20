module A (
    input x,
    input y,
    output z
);

    assign z = x ^ y & x;
    
endmodule
module B (
    input x,
    input y,
    output z
);

    always @(x or y)
    begin
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

    wire a_out_1, b_out_1, a_out_2, b_out_2;
    
    A a1 (
        .x(x),
        .y(y),
        .z(a_out_1)
    );
    
    B b1 (
        .x(x),
        .y(y),
        .z(b_out_1)
    );
    
    A a2 (
        .x(x),
        .y(y),
        .z(a_out_2)
    );
    
    B b2 (
        .x(x),
        .y(y),
        .z(b_out_2)
    );
    
    wire or_out, and_out;
    
    assign or_out = a_out_1 | b_out_1;
    assign and_out = a_out_2 & b_out_2;
    
    assign z = xor(or_out, and_out);
    
endmodule
