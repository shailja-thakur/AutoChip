module and_gate(
    input a,
    input b,
    output c);
    
    assign c = a & b;
    
endmodule
module or_gate(
    input a,
    input b,
    output c);
    
    assign c = a | b;
    
endmodule
module xor_gate(
    input a,
    input b,
    output c);
    
    assign c = a ^ b;
    
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
    
    assign #5 z = (x & y) | (x & ~y) | (~x & y) | (~x & ~y);
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a_out, b_out, c_out;
    
    A a1(.x(x), .y(y), .z(a_out));
    B b1(.x(x), .y(y), .z(b_out));
    
    A a2(.x(x), .y(y), .z(a_out));
    B b2(.x(x), .y(y), .z(b_out));
    
    or_gate or1(.a(a_out), .b(b_out), .c(c_out));
    and_gate and1(.a(a_out), .b(b_out), .c(c_out));
    
    xor_gate xor1(.a(or1.c), .b(and1.c), .c(z));
    
endmodule
