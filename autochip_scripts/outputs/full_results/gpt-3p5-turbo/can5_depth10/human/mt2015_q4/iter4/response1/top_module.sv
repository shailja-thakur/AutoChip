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
        // Testbench
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        
        x = 0; y = 0;
        #5;
        
        x = 0; y = 0;
        #5;
        
        x = 0; y = 0;
        #5;
        
        x = 0; y = 0;
        #5;
        
        x = 0; y = 0;
        #5;
        
        x = 1; y = 0;
        #5;
        
        x = 1; y = 0;
        #5;
        
        x = 0; y = 1;
        #5;
        
        x = 0; y = 1;
        #5;
        
        x = 1; y = 1;
        #5;
        
        x = 1; y = 1;
        #5;
        
        x = 0; y = 0;
        #5;
        
        x = 0; y = 1;
        #5;
        
        x = 0; y = 1;
        #5;
        
        x = 1; y = 1;
        #5;
        
        x = 0; y = 1;
        #5;
        
        x = 0; y = 1;
        #5;
        
        x = 0; y = 1;
        #5;
        
        x = 1; y = 0;
        #5;
        
        $finish;
    end
    
endmodule
