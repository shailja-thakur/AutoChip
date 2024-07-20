module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 10'd0; // Reset the counter to 0
        else if (q == 10'd999)
            q <= 10'd0; // Wrap around when counter reaches 999
        else
            q <= q + 10'd1; // Increment the counter
    end
endmodule
