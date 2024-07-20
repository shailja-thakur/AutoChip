module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk) begin
		if (E) begin
			if (R)
				Q <= 1'b0;
			else if (L)
				Q <= R;
			else
				Q <= w;
		end
		else begin
			Q <= Q;
		end
	end

endmodule
