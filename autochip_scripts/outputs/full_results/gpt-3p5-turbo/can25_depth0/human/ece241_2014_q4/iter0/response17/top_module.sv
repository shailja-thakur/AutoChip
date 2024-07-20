module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;

assign z = ~(q1 ^ q2 ^ q3);

always @(posedge clk)
begin
	d1 <= x ^ q1;
	d2 <= ~q2 & x;
	d3 <= ~q3 | x;
end

dff dff1 (.clk(clk), .d(d1), .q(q1));
dff dff2 (.clk(clk), .d(d2), .q(q2));
dff dff3 (.clk(clk), .d(d3), .q(q3));

endmodule
