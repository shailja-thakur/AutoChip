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

    assign z = (x ^ y) & ~x;
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire z1, z2, z3, z4, or_out, and_out;
    
    A A1(x, y, z1);
    A A2(x, y, z2);
    B B1(x, y, z3);
    B B2(x, y, z4);
    
    or_gate or1(z1, z3, or_out);
    and_gate and1(z2, z4, and_out);
    
    xor_gate xor1(or_out, and_out, z);
    
endmodule
module or_gate(
    input a,
    input b,
    output z);
    
    assign z = a | b;
    
endmodule
module and_gate(
    input a,
    input b,
    output z);
    
    assign z = a & b;
    
endmodule
module xor_gate(
    input a,
    input b,
    output z);
    
    assign z = a ^ b;
    
endmodule
