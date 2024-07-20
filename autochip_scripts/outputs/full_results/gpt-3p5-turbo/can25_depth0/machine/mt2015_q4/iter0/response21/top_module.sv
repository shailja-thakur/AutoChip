module top_module(
    input wire x,
    input wire y,
    output wire z);
    
    wire a, b;
    
    // First gate
    or_gate or1(x, y, a);
    
    // Second gate
    or_gate or2(y, x, b);
    
    // Third gate
    and_gate and1(a, b, z);
    
endmodule
module or_gate(
    input wire a,
    input wire b,
    output wire out);
    
    assign out = a | b;
    
endmodule
module and_gate(
    input wire a,
    input wire b,
    output wire out);
    
    assign out = a & b;
    
endmodule
