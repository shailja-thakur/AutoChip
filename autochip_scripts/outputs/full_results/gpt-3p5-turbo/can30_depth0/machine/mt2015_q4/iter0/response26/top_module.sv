module top_module(
    input x,
    input y,
    output z);

    wire a;
    wire b;
    
    and_gate u1(.a(x), .b(y), .z(a));
    and_gate u2(.a(y), .b(x), .z(b));
    and_gate u3(.a(a), .b(b), .z(z));
    
endmodule
module and_gate(
    input a,
    input b,
    output z);
    
    assign z = a & b;
    
endmodule
