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
    
    assign #0 z = (x & y) | (x ^ y);
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1_z, a2_z, b1_z, b2_z;
    
    A u1 (.x(x), .y(y), .z(a1_z));
    A u2 (.x(x), .y(y), .z(a2_z));
    
    B u3 (.x(x), .y(y), .z(b1_z));
    B u4 (.x(x), .y(y), .z(b2_z));
    
    wire or_gate_out = a1_z | b1_z;
    wire and_gate_out = a2_z & b2_z;
    
    assign z = xor(or_gate_out, and_gate_out);
    
endmodule
