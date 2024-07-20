module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

always @(posedge clk or posedge reset)
begin
    if (reset)
        q <= 4'b0000; // Reset the counter to 0
    else if (q == 4'b1001) // If counter reaches 9
        q <= 4'b0000; // Reset the counter to 0
    else
        q <= q + 4'b0001; // Increment the counter
end

endmodule
