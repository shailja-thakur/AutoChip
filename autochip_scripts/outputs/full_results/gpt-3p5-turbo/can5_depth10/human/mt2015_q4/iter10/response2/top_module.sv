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
    
    initial begin
        $monitor("time=%t x=%b y=%b z=%b", $time, x, y, z);
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
        $finish;
    end
    
endmodule
