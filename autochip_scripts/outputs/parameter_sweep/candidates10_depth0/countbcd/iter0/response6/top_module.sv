module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else if (ena[1])
            q <= q + 10;
        else if (ena[2])
            q <= q + 100;
        else if (ena[3])
            q <= q + 1000;
    end
endmodule
