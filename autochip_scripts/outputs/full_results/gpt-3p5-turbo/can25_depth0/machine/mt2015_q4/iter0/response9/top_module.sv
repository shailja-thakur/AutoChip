module top_module(
    input x,
    input y,
    output z);
    
    wire a, b;
    
    and gate1(a, x, y);
    and gate2(b, x, y);
    or gate3(z, a, b);
    
endmodule
