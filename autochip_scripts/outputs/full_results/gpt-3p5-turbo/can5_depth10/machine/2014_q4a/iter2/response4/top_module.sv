module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	reg Q_reg;
	
	always @(posedge clk or posedge R or posedge L) begin
		if (R) begin
			Q_reg <= 1'b0;
		end
		else if (E) begin
			if (L) begin
				Q_reg <= R;
			end
			else begin
				Q_reg <= w;
			end
		end
	end

	always @(posedge clk) begin
		Q <= Q_reg;
	end

endmodule
