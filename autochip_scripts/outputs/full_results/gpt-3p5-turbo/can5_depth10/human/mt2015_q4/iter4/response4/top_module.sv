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

    or or_gate_instance (.a(z1), .b(z3), .z(or_out));
    and and_gate_instance (.a(z2), .b(z4), .z(and_out));
    xor xor_gate_instance (.a(or_out), .b(and_out), .z(z));
    
endmodule
