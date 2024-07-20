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
		Q <= Q;  // hold current state
	end else begin
		if (L == 1) begin
			Q <= R;  // update Q with R
		end else begin
			Q <= w;  // update Q with w
		end
	end
end

endmodule
