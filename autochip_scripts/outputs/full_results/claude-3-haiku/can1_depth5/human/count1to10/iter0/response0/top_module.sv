module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 4'b0001; // Reset counter to 1
    else if (q == 4'b1010) // Count reached 10
        q <= 4'b0001; // Reset counter to 1
    else
        q <= q + 1; // Increment counter
end

endmodule
