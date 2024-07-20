module top_module(
    input x,
    input y,
    output z);
    
    wire z1, z2, z3, z4, or_out, and_out;
    A A1(x, y, z1);
    B B1(x, y, z2);
    A A2(x, y, z3);
    B B2(x, y, z4);

    assign or_out = z1 | z2;
    assign and_out = z3 & z4;
    assign z = or_out ^ and_out;
    
endmodule
module A(
    input x,
    input y,
    output z);
    
    wire temp;
    assign temp = x ^ y;
    assign z = temp & x;
    
endmodule
module B(
    input x,
    input y,
    output z);

    wire temp;
    assign temp = x | y;
    assign z = temp & (~x);
    
endmodule
