module top_module(
    input clk,
    input reset,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;  // Reset the counter to 0 on reset
        end
        else begin
            q <= q + 1;    // Increment the counter by 1
        end
    end
    
endmodule
