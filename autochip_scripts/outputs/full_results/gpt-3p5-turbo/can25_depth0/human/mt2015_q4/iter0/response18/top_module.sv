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
    assign z = z;
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1_z, a2_z, b1_z, b2_z;
    
    A a1(x, y, a1_z);
    B b1(x, y, b1_z);
    
    A a2(x, y, a2_z);
    B b2(x, y, b2_z);
    
    or or_gate(a1_z, b1_z, z);
    and and_gate(a2_z, b2_z, z);
    xor xor_gate(z, z, z);
    
endmodule
