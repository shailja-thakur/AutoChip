module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire xor_out, and_out, or_out;

assign xor_out = d1 ^ d1;
assign and_out = d2 & ~d2;
assign or_out = d3 | ~d3;

xnor_u0 xnor1 (
	.x1(xor_out),
	.x2(and_out),
	.x3(or_out),
	.z(z)
);

always @(posedge clk) begin
	d1 <= x;
	d2 <= x;
	d3 <= x;
end

endmodule
