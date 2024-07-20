module top_module (
	input clk,
	input in,
	output reg out
);

	always @(posedge clk) begin
		if (in && ~out) begin
			out <= 1;
		end else if (~in && out) begin
			out <= 0;
		end
	end

endmodule
