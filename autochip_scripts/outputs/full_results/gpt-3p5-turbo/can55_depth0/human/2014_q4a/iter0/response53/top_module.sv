module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
	reg Q_temp;
	
	always @(posedge clk) begin
		if (E) begin
			if (L)
				Q_temp <= R;
			else
				Q_temp <= Q;
		end
		else
			Q_temp <= Q;
	end
	
	always @(posedge clk) begin
		if (E)
			Q <= Q_temp;
		else if (L)
			Q <= R;
		else
			Q <= Q;
	end
	
	assign Q = w | Q_temp;
endmodule
