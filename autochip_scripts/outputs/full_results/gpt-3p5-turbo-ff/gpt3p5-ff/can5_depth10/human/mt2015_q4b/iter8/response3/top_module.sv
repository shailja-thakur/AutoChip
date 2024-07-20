module top_module(
    input x,
    input y,
    output z);
    
    assign z = x & y;
    
    initial begin
        $display("x   y   z");
        $monitor("%b   %b   %b", x, y, z);
        
        #0 x = 0; y = 0; // Initial values
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        #5;
        
        $finish;
    end
endmodule
