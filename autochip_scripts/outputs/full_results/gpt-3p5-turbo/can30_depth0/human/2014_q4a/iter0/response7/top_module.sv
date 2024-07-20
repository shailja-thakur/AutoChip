module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	
	// Flip-flop
	always @(posedge clk) begin
		if (L) begin
			if (E)
				Q <= R;
			else
				Q <= w;
		end
		else begin
			Q <= Q;
		end
	end
	
endmodule
