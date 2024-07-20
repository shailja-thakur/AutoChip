module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D;
reg enable;

always @(posedge clk) begin
	if (E)
		enable <= 1;
	else
		enable <= 0;
end

always @(posedge clk) begin
	if (L)
		D <= R;
	else if (enable)
		D <= w;
end

always @(posedge clk) begin
	if (enable)
		Q <= D;
	else
		Q <= Q;
end

endmodule
