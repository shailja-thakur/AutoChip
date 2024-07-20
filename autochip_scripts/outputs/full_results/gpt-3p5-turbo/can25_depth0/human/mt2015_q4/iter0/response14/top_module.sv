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
    
    assign z = #(10, 15, 20, 25, 60) !x & y;
    
  endmodule
module OR_gate(
    input a,
    input b,
    output c);
    
    assign c = a | b;
    
  endmodule
module AND_gate(
    input a,
    input b,
    output c);
    
    assign c = a & b;
    
  endmodule
module XOR_gate(
    input a,
    input b,
    output c);
    
    assign c = a ^ b;
    
  endmodule
module top_module(
    input x,
    input y,
    output z);
    
    A A1(
      .x(x),
      .y(y),
      .z(z_a1));
      
    B B1(
      .x(x),
      .y(y),
      .z(z_b1));
      
    A A2(
      .x(x),
      .y(y),
      .z(z_a2));
      
    B B2(
      .x(x),
      .y(y),
      .z(z_b2));
      
    OR_gate OR1(
      .a(z_a1),
      .b(z_b1),
      .c(out_or));
      
    AND_gate AND1(
      .a(z_a2),
      .b(z_b2),
      .c(out_and));
      
    XOR_gate XOR1(
      .a(out_or),
      .b(out_and),
      .c(z));
    
  endmodule
