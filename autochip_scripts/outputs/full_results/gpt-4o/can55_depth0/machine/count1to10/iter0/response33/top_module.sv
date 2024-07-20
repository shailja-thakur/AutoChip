module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		q <= 4'b0001; // Set output register to 1
	end else if (q == 4'b1010) begin
		q <= 4'b0001; // Reset output register to 1 when it reaches 10 (1010 in binary)
	end else begin
		q <= q + 1; // Increment output register by one
	end
end

endmodule
