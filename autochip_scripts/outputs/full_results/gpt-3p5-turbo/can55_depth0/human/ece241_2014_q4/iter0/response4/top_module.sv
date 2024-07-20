module top_module (
	input clk,
	input x,
	output reg z
);

	reg d1;
	reg d2;
	reg d3;

	always @(posedge clk) begin
		d1 <= x ^ d1;
		d2 <= ~(x & d2);
		d3 <= ~(x | d3);
	end

	assign z = d1 ^ d2 ^ d3;

endmodule
