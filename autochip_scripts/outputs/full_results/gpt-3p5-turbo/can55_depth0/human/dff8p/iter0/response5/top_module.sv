module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_sync;
	always @(posedge clk or negedge reset) begin
		if (!reset)
			q_sync <= 8'b00110100;
		else if (negedge clk)
			q_sync <= d;
	end

	always @(posedge clk) begin
		q <= q_sync;
	end

endmodule
