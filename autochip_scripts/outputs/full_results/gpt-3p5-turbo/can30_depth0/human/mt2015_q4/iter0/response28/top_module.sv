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
    output z
);

    reg z;
    
    always @(x or y) begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase
    end
    
    assign z = z;
    
endmodule
module OR_GATE (
    input a,
    input b,
    output z
);

    assign z = a | b;
    
endmodule
module AND_GATE (
    input a,
    input b,
    output z
);

    assign z = a & b;
    
endmodule
module XOR_GATE (
    input a,
    input b,
    output z
);

    assign z = a ^ b;
    
endmodule
module top_module (
    input x,
    input y,
    output z
);

    wire a1_z, a2_z, b1_z, b2_z;
    
    A a1 (
        .x(x),
        .y(y),
        .z(a1_z)
    );
    
    A a2 (
        .x(x),
        .y(y),
        .z(a2_z)
    );
    
    B b1 (
        .x(x),
        .y(y),
        .z(b1_z)
    );
    
    B b2 (
        .x(x),
        .y(y),
        .z(b2_z)
    );
    
    OR_GATE or_gate (
        .a(a1_z),
        .b(b1_z),
        .z(z)
    );
    
    AND_GATE and_gate (
        .a(a2_z),
        .b(b2_z),
        .z(z)
    );
    
    XOR_GATE xor_gate (
        .a(z),
        .b(z),
        .z(z)
    );
    
endmodule
