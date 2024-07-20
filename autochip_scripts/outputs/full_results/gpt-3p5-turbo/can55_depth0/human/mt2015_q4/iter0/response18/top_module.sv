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
    
    assign z = #(5ns) {1'b1, 5'b0};
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire w1, w2, w3, w4;
    
    A a1 (x, y, w1);
    B b1 (x, y, w2);
    A a2 (x, y, w3);
    B b2 (x, y, w4);
    
    or  #(5ns) or_gate (w1, w2, z);
    and #(5ns) and_gate (w3, w4, z);
    
endmodule
