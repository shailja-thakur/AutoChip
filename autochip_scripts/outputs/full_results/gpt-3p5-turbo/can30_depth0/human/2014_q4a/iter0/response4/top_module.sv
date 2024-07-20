module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	reg Q_n;

	always @(posedge clk) begin
		if (L)
			Q <= R;
		else if (E)
			Q <= Q_n;
	end

	always @(posedge clk) begin
		Q_n <= w;
	end

endmodule
