module top_module(
	input clk,
	input d,
	output reg q);

	reg q_internal;
	always @(posedge clk) begin
		q_internal <= d;
	end

	always @(negedge clk) begin
		q_internal <= d;
	end

	assign q = q_internal;

endmodule
