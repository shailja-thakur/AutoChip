module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg stage;

always @(posedge clk) begin
	if (L)
		stage <= R;
	else if (E)
		stage <= w;
	else
		stage <= stage;
end

always @(posedge clk) begin
	if (L)
		Q <= stage;
	else
		Q <= Q;
end

endmodule
