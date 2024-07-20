module top_module(
    input clk,
    input reset,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 4'b0;
        end else begin
            q <= q + 1;
        end
    end
    
endmodule
