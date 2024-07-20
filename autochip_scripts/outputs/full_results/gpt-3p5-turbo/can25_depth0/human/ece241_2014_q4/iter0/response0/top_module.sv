module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire not_d1, not_d2, not_d3;

assign not_d1 = ~d1;
assign not_d2 = ~d2;
assign not_d3 = ~d3;

always @(posedge clk) begin
	d1 <= x ^ d1;
	d2 <= x & not_d2;
	d3 <= x | not_d3;
end

assign z = ~(d1 ^ d2 ^ d3);

endmodule
