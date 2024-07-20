module top_module(
	input clk,
	input d,
	output reg q);

	reg sync_d;
	reg q_synced;

	always @(posedge clk) begin
		sync_d <= d;
	end
	
	always @(posedge clk) begin
		q_synced <= sync_d;
	end

	always @(posedge clk) begin
		q <= q_synced;
	end

endmodule
