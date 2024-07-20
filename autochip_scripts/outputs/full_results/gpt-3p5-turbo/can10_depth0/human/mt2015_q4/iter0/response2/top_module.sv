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
    
    assign z = #5 x & y;
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1, a2, b1, b2, o1, o2;
    
    A A1(x, y, a1);
    A A2(x, y, a2);
    B B1(x, y, b1);
    B B2(x, y, b2);
    
    assign o1 = a1 | b1;
    assign o2 = a2 & b2;
    
    assign z = o1 ^ o2;
    
endmodule
