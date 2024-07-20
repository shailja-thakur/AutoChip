module top_module(
	input clk,
	input d,
	output reg q);

	always @(posedge clk) begin
		if (clk === 1'b0) begin
			q <= d;
		end else begin
			q <= q;
		end
	end

endmodule
