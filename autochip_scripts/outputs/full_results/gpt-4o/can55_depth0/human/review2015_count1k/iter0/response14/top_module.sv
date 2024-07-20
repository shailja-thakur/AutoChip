module top_module(
    input clk,
    input reset,
    output reg [9:0] q);
    
    always @(posedge clk) begin
        if (reset) 
            q <= 10'd0; // Reset the counter to 0
        else 
            q <= (q == 10'd999) ? 10'd0 : q + 10'd1; // Increment counter or reset to 0 if it reaches 999
    end
endmodule
