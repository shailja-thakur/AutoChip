module top_module(
    input clk,
    input d,
    output reg q);
    
    register r(.clk(clk), .d(d), .q(q));
    
endmodule
module register(
    input clk,
    input d,
    output reg q);
    
    reg [0:0] q;
    
    always @(posedge clk)
        q <= d;
    
    initial
        q = 1'hx;
        
endmodule
