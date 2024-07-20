module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	
	reg temp;
	always @(posedge clk) begin
		if (L)
			Q <= R;
		else begin
			if (E)
				Q <= temp;
			else
				Q <= w;
		end
		temp <= Q;
	end
	
endmodule
