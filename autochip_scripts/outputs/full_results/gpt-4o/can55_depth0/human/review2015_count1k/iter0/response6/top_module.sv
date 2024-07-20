module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk) begin
        if (reset) 
            q <= 0;
        else 
            q <= (q == 999) ? 0 : q + 1;
    end
endmodule
