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
    
    reg z;
    
    always @(x or y)
    begin
        if (x == 0'b0 && y == 0'b0)
            z = 1'b1;
        else if (x == 1'b1 && y == 0'b0)
            z = 1'b0;
        else if (x == 0'b0 && y == 1'b0)
            z = 1'b0;
        else if (x == 1'b1 && y == 1'b1)
            z = 1'b1;
    end
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1_out, a2_out, b1_out, b2_out, or_out, and_out;
    
    A A1(x, y, a1_out);
    A A2(x, y, a2_out);
    B B1(x, y, b1_out);
    B B2(x, y, b2_out);
    
    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;
    
endmodule
