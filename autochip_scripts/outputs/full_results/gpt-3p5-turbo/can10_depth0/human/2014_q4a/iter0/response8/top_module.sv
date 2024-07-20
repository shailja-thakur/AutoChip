module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D;

always @(posedge clk) begin
	if (E) begin
		if (L)
			D <= R;
		else
			D <= Q;
	end else begin
		D <= Q;
	end
	Q <= D;
end

mux2to1 M(
	.x0(R),
	.x1(Q),
	.s(E),
	.y(Q)
);

endmodule
module mux2to1 (
	input x0,
	input x1,
	input s,
	output reg y
);

always @(x0, x1, s) begin
	if (s)
		y <= x1;
	else
		y <= x0;
end

endmodule
