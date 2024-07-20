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

    assign z = (x ^ y) & ~x;
    
endmodule
module top_module(
    input x,
    input y,
    output reg z);
    
    wire z1, z2, z3, z4, or_out, and_out;
    A A1(x, y, z1);
    A A2(x, y, z2);
    B B1(x, y, z3);
    B B2(x, y, z4);

    assign or_out = z1 | z3;
    assign and_out = z2 & z4;
    
    always @(or_out, and_out) begin
        z <= or_out ^ and_out;
    end
    
endmodule
