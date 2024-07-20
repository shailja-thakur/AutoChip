module top_module(
    input x,
    input y,
    output z);
    
    wire z1, z2, z3, z4, or_out, and_out;
    A A1(x, y, z1);
    A A2(x, y, z2);
    B B1(x, y, z3);
    B B2(x, y, z4);

    assign or_out = z1 | z3;
    assign and_out = z2 & z4;
    assign z = or_out ^ and_out;

    initial begin
        #0 x = 0; y = 0;
        #5 x = 0; y = 0;
        #10 x = 0; y = 0;
        #15 x = 0; y = 0;
        #20 x = 0; y = 0;
        #25 x = 1; y = 0;
        #30 x = 1; y = 0;
        #35 x = 0; y = 1;
        #40 x = 0; y = 1;
        #45 x = 1; y = 1;
        #50 x = 1; y = 1;
        #55 x = 0; y = 0;
        #60 x = 0; y = 1;
        #65 x = 0; y = 1;
        #70 x = 1; y = 1;
        #75 x = 0; y = 1;
        #80 x = 0; y = 1;
        #85 x = 0; y = 1;
        #90 x = 1; y = 0;
        #100 $finish;
    end
    
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
