module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D;
reg Q_temp;

always @(posedge clk) begin
	if (L && E)
		Q_temp <= R;
	else if (E)
		Q_temp <= Q;
	else
		Q_temp <= Q;

	D <= Q_temp;
end

always @(posedge clk) begin
	if (!E)
		Q <= D;
	else
		Q <= w;
end

endmodule
