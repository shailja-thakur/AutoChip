module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Reset or increment counter on rising edge of the clock
    always @(posedge clk) begin
        if (reset || q == 4'b1001) 
            q <= 4'b0000; // If reset is high or q reaches 9, reset q to 0
        else 
            q <= q + 4'b0001; // Otherwise, increment q by 1
    end
endmodule
