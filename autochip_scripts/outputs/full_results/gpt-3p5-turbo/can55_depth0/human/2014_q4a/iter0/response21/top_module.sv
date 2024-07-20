module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	reg Q_temp;
	always @(posedge clk)
	begin
		if (L)
			Q_temp <= R;
		else if (E)
			Q_temp <= w;
		else
			Q_temp <= Q;
	end
	
	assign Q = Q_temp;
endmodule
