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
    
    assign z = #10 {1'b0, 2'b10, 1'b1, 3'b000};
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a_out1, a_out2, b_out1, b_out2;
    wire or_out, and_out;
    
    A u1(x, y, a_out1);
    B u2(x, y, b_out1);
    A u3(x, y, a_out2);
    B u4(x, y, b_out2);
    
    or and_gate_1(or_out, a_out1, b_out1);
    and and_gate_2(and_out, a_out2, b_out2);
    xor xor_gate(z, or_out, and_out);
    
endmodule
module and(
    input a,
    input b,
    output y);

    assign y = a & b;
    
endmodule
module or(
    input a,
    input b,
    output y);
    
    assign y = a || b;
    
endmodule
module xor(
    input a,
    input b,
    output y);
    
    assign y = a ^ b;
    
endmodule
