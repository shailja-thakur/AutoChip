module top_module(
    input clk,
    input reset,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if (reset) 
            q <= 4'b0000;
        else
            q <= q + 1'b1;
    end
endmodule
