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
    
    assign z =  #(0, 5, 5, 5, 5, 5, 5, 5, 25, 5, 5, 5, 5, 5, 5, 
                 70, 5, 5, 5, 5, 5, 5, 5, 90) 
        {(x & ~y & ~z), (x & ~y & ~z), (x & ~y & ~z), (x & ~y & ~z), 
         (x & ~y & ~z), (x & ~y & ~z), (x & ~y & ~z), (x & ~y & ~z), 
         (x & ~y & ~z), (x & ~y & ~z), (x & ~y & ~z), (x & ~y & ~z), 
         (x & ~y & ~z), (x & ~y & ~z), (x & ~y & ~z), (x & ~y & ~z)};
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1, a2, b1, b2, or_out, and_out;
    
    A A1(x, y, a1);
    A A2(x, y, a2);
    B B1(x, y, b1);
    B B2(x, y, b2);
    
    assign or_out = a1 | b1;
    assign and_out = a2 & b2;
    assign z = or_out ^ and_out;
    
endmodule
