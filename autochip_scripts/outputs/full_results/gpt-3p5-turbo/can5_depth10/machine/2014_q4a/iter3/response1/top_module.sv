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
		if (E == 1'b0) begin
			Q <= Q;
		end
		else begin
			if (L == 1'b1)
				Q_tmp <= R;
			else
				Q_tmp <= w;
		end
	end

	always @(posedge clk) begin
		if (E == 1'b1) begin
			Q <= Q_tmp;
		end
	end

endmodule
