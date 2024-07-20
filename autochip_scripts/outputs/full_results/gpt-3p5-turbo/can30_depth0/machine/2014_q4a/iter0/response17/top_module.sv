module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk) begin
		if (E == 0) begin
			// hold current state
			Q <= Q;
		end else begin
			if (L == 0) begin
				// update with w
				Q <= w;
			end else begin
				// update with R
				Q <= R;
			end
		end
	end
endmodule
