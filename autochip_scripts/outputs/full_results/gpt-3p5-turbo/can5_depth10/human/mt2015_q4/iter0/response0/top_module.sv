module top_module(
    input x,
    input y,
    output z);

    wire a1_z;
    wire b1_z;
    wire a2_z;
    wire b2_z;
    wire or_out;
    wire and_out;
    
    A a1(.x(x), .y(y), .z(a1_z));
    B b1(.x(x), .y(y), .z(b1_z));
    A a2(.x(x), .y(y), .z(a2_z));
    B b2(.x(x), .y(y), .z(b2_z));
    
    or_gate or1(.a(a1_z), .b(b1_z), .z(or_out));
    and_gate and1(.a(a2_z), .b(b2_z), .z(and_out));
    
    xor_gate xor1(.a(or_out), .b(and_out), .z(z));
    
endmodule
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
        case({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase

endmodule
module and_gate(
    input a,
    input b,
    output z);

    assign z = a & b;
    
endmodule
module or_gate(
    input a,
    input b,
    output z);

    assign z = a | b;
    
endmodule
module xor_gate(
    input a,
    input b,
    output z);

    assign z = a ^ b;
    
endmodule
