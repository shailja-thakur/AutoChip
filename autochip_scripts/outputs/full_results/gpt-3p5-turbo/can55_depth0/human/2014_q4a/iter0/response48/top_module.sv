module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	
	reg Q_out;
	
	always @(posedge clk) begin
		if (E) begin
			if (L) begin
				Q_out <= R;
			end
			else begin
				Q_out <= w;
			end
		end
		else begin
			Q_out <= Q;
		end
	end
	
	always @(posedge clk) begin
		Q <= Q_out;
	end
	
endmodule
