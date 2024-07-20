module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0000; // Reset q to 0
        else if (q == 4'd9)
            q <= 4'b0000; // If q is equal to 9, reset to 0
        else
            q <= q + 1'b1; // Otherwise, increment q by 1
    end

endmodule
