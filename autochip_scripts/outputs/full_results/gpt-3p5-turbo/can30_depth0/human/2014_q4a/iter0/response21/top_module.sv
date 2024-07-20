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
			Q_next <= (L) ? R : (w & Q);
		else
			Q_next <= Q;
	end

	always @(posedge clk) begin
		Q <= Q_next;
	end

endmodule
