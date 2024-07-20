module top_module(
    input x,
    input y,
    output z);
    
    wire a1;
    wire b1;
    wire a2;
    wire b2;
    
    and gate1(a1, x, y);
    and gate2(b1, y, x);
    or gate3(z, a1, b1);
    
endmodule
