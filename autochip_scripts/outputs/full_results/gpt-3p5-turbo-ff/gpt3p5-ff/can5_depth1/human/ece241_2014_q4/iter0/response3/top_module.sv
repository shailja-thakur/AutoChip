module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;
reg z;

always @(posedge clk) begin
    d1 <= x ^ q1;
    d2 <= x & (~q2);
    d3 <= x | (~q3);
end

always @(posedge clk) begin
    z <= ~(q1 ^ q2 ^ q3);
end

endmodule
