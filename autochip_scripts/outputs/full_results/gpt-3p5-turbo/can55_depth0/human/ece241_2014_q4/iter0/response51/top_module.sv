module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;

always @(posedge clk) begin
	d1 <= x ^ q1;
	d2 <= x & ~q2;
	d3 <= x | ~q3;
end

assign q1 = d1;
assign q2 = d2;
assign q3 = d3;

assign z = ~(q1 ^ q2 ^ q3);

endmodule
