module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;
wire y1, y2, y3;

assign y1 = q1 ^ d1;
assign y2 = ~(q2 ^ d2);
assign y3 = q3 ^ d3;
assign z = y1 ^ y2 ^ y3;

always @(posedge clk)
begin
    d1 <= y2;
    d2 <= ~y1;
    d3 <= ~y2;
end

d_ff dff1 (.clk(clk), .d(x), .q(q1));
d_ff dff2 (.clk(clk), .d(y1), .q(q2));
d_ff dff3 (.clk(clk), .d(y2), .q(q3));

endmodule
module d_ff (
	input clk,
	input d,
	output q
);

always @(posedge clk)
begin
    q <= d;
end

endmodule
