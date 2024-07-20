module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 4'b0001; // Reset the counter to 1
    else if (q == 4'b1010) // Check if the count has reached 10
        q <= 4'b0001; // Reset the count to 1
    else
        q <= q + 1; // Increment the counter
end

endmodule
