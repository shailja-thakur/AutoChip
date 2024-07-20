module top_module(
    input x,
    input y,
    output z);
    
    wire z1, z2, z3, z4, or_out, and_out;
    A A1(.x(x), .y(y), .z(z1));
    A A2(.x(x), .y(y), .z(z2));
    B B1(.x(x), .y(y), .z(z3));
    B B2(.x(x), .y(y), .z(z4));

    assign or_out = z1 | z3;
    assign and_out = z2 & z4;
    assign z = or_out ^ and_out;
    
endmodule
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

    assign z = (x | y) & ~x;
    
endmodule
