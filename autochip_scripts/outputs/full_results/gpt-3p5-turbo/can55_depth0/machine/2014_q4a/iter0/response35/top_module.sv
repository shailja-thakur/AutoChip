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
		Q <= Q; // Hold output Q in its current state
	end else begin
		if (L == 0) begin
			Q <= w; // Update output Q with the value of w
		end else begin
			Q <= R; // Update output Q with the value of R
		end
	end
end

endmodule
