module top_module(
	input x,
    input y,
    output z);
    
    wire a, b, c;
    
    and_gate and1(.a(x), .b(y), .z(a)); // First gate
    and_gate and2(.a(y), .b(x), .z(b)); // Second gate
    and_gate and3(.a(a), .b(b), .z(c)); // Third gate
    assign z = c;
    
endmodule
module and_gate(
    input a,
    input b,
    output z);
    
    assign z = a & b;
    
endmodule
