module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);

	integer i;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q <= 8'b0; // Reset all flip-flops to 0
		end else begin
			for (i = 0; i < 8; i = i + 1) begin
				q[i] <= d[i]; // Capture the data on the positive edge of clk
			end
		end
	end

endmodule
