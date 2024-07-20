module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	reg Q_tmp;

	always @(posedge clk) begin
		if (L) begin
			Q <= R;
		end else if (E) begin
			Q <= Q_tmp;
		end else begin
			Q <= w;
		end
	end

	always @(posedge clk) begin
		Q_tmp <= Q;
	end

endmodule
