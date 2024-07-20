module and_gate(
    input a,
    input b,
    output y);
    
    assign y = a & b;
    
endmodule
module or_gate(
    input a,
    input b,
    output y);
    
    assign y = a | b;
    
endmodule
module top_module(
    input x,
    input y,
    output z);

    wire a, b;
    
    // First Gate
    and_gate u1(x, y, a);
    
    // Second Gate
    and_gate u2(y, x, b);
    
    // Third Gate
    or_gate u3(a, b, z);
    
endmodule
