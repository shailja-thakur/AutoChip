module top_module(
    input x,
    input y,
    output z);
    
    wire w1;
    
    xor_gate XOR1 (.a(x), .b(y), .o(w1));
    and_gate AND1 (.a(w1), .b(x), .o(z));
    
endmodule
module xor_gate(
    input a,
    input b,
    output o);
    
    assign o = a ^ b;
    
endmodule
module and_gate(
    input a,
    input b,
    output o);
    
    assign o = a & b;
    
endmodule
