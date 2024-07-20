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
    
    assign z = #5 x & ~y;
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1_out, a2_out, b1_out, b2_out;
    
    A a1(x, y, a1_out);
    A a2(x, y, a2_out);
    B b1(x, y, b1_out);
    B b2(x, y, b2_out);
    
    wire or_out, and_out;
    
    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    
    assign z = #10 or_out ^ and_out;
    
endmodule
