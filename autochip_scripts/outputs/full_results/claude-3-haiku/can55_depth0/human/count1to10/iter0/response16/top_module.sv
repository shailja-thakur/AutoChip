module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset to 1
    end
    else if (q == 4'b1010) // Check for count of 10
        q <= 4'b0001; // Rollover to 1
    else
        q <= q + 1; // Increment the counter
end

endmodule
