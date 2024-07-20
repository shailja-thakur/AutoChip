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
    
    assign z = #0 (x == 0 && y == 0) || #0 (x == 1 && y == 1);
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    A A1(.x(x), .y(y), .z(z_A1));
    A A2(.x(x), .y(y), .z(z_A2));
    B B1(.x(x), .y(y), .z(z_B1));
    B B2(.x(x), .y(y), .z(z_B2));
    
    or #5 OR_gate(.A(z_A1), .B(z_B1), .z(z_or));
    and #5 AND_gate(.A(z_A2), .B(z_B2), .z(z_and));
    xor #5 XOR_gate(.A(z_or), .B(z_and), .z(z));
    
endmodule
