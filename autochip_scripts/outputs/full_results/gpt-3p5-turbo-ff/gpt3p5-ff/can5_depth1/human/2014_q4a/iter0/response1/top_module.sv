module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	reg D;
	reg Qn;
	
	// D Flip Flop
	always@(posedge clk) begin
		if (L)
			D <= R;
		else if (E)
			D <= Qn;
		else
			D <= 1'b0;
			
		Qn <= Q;
		Q <= D;
	end
	
	// Mux
	always@(*) begin
		if (E)
			Q <= w;
	end
	
endmodule
