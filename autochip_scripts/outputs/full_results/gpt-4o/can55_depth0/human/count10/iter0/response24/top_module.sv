module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) 
            q <= 4'b0000; // Reset the counter to 0
        else if (q == 4'b1001) 
            q <= 4'b0000; // Reset the counter to 0 after 9
        else 
            q <= q + 1;
    end

endmodule
