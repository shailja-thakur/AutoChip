module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] d_ff [7:0];

	always @(negedge clk) begin
		if (reset)
			q <= 8'h34;
		else
			q <= d_ff[7:0];
	end

	always @(posedge clk) begin
		if (reset)
			d_ff[7:0] <= 8'h34;
		else
			d_ff[7:0] <= d;
	end

endmodule
