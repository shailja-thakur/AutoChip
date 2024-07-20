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

    assign z = (x ^ y) & y;
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire z1, z2, or_out, and_out;
    A A1(x, y, z1);
    B B1(x, y, z2);

    assign or_out = z1 | z2;
    assign and_out = z1 & z2;
    assign z = or_out ^ and_out;
    
endmodule
module top_module_tb();
    
    reg x, y;
    wire z;
    
    top_module DUT(x, y, z);
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
        
        x = 0; y = 0; #0;
        x = 0; y = 0; #5;
        x = 0; y = 0; #10;
        x = 0; y = 0; #15;
        x = 0; y = 0; #20;
        x = 1; y = 0; #25;
        x = 1; y = 0; #30;
        x = 0; y = 1; #35;
        x = 0; y = 1; #40;
        x = 1; y = 1; #45;
        x = 1; y = 1; #50;
        x = 0; y = 0; #55;
        x = 0; y = 1; #60;
        x = 0; y = 1; #65;
        x = 1; y = 1; #70;
        x = 0; y = 1; #75;
        x = 0; y = 1; #80;
        x = 0; y = 1; #85;
        x = 1; y = 0; #90;
        
        $display("Simulation finished");
        $finish;
    end
    
endmodule
module testbench();
    
    top_module_tb tb();
    
endmodule
