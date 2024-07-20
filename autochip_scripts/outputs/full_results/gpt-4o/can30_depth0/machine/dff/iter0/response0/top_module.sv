module top_module(
    input clk,
    input d,
    output reg q);
    
    initial begin
        q = 1'bx; // Initial value of the register signal q is unknown/undefined
    end
    
    always @(posedge clk) begin
        q <= d; // On the rising edge of the clock, set q to the value of d
    end
    
endmodule
