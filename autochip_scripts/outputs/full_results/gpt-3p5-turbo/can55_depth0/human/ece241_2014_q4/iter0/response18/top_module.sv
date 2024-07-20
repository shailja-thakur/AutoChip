module top_module (
	input clk,
	input x,
	output Z
);

reg d1, d2, d3;
wire q1, q2, q3;

assign Z = !(q1 ^ q2 ^ q3);

xor gate1(q1, x, d1);
and gate2(q2, x, d2);
or gate3(q3, x, d3);

always @(posedge clk) begin
    d1 <= q1;
    d2 <= ~q2;
    d3 <= ~q3;
end

endmodule
