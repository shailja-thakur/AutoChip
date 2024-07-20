module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg Q_next;

always @(posedge clk) begin
	if (E)
		Q_next <= R;
	else if (L)
		Q_next <= w;
	else
		Q_next <= Q;
end

always @(posedge clk) begin
	if (E || L)
		Q <= Q_next;
end

endmodule
