module top_module (
	input clk,
	input in,
	output reg out
);

	always @(posedge clk) begin
		out <= ~out;
	end

	initial begin
		$monitor("out=%d", out);
	end

endmodule
