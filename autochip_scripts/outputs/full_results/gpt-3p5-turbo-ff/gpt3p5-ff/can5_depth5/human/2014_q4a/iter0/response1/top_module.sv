module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	reg Q_reg;
	always@(posedge clk)
	begin
		if(L)
			Q_reg <= R;
		else if(E)
			Q_reg <= w;
	end
	
	assign Q = Q_reg;
endmodule
