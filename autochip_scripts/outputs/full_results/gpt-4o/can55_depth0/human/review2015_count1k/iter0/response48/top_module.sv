module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk) begin
        if (reset) 
            q <= 10'd0;                       // Synchronous reset to 0
        else if (q == 10'd999) 
            q <= 10'd0;                       // Wrap around at 1000
        else 
            q <= q + 10'd1;                   // Increment counter
    end

endmodule
