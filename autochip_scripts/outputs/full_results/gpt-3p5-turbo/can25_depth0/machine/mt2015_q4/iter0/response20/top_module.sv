module top_module(
    input x,
    input y,
    output z);
    
    wire a;
    wire b;
    
    // First gate
    andgate u1(.a(x), .b(y), .z(a));
    
    // Second gate
    andgate u2(.a(y), .b(x), .z(b));
    
    // Third gate
    orgate u3(.a(a), .b(b), .z(z));
    
    endmodule
module andgate(
        input a,
        input b,
        output z);
        
        assign z = a & b;
        
    endmodule
module orgate(
        input a,
        input b,
        output z);
        
        assign z = a | b;
        
    endmodule
