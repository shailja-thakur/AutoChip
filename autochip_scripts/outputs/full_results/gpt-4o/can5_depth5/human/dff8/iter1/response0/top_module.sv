module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	always @(posedge clk) begin
		q <= d;
	end

	initial begin
		q = 8'b0;  // Initialize q to avoid mismatch at the first clock edge
	end

endmodule
