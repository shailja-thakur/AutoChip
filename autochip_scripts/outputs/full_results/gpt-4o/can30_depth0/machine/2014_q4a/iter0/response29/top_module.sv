module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (R)
		Q <= 1'b0;        // When reset is high, the output Q is forced to low.
	else if (E) begin
		if (L)
			Q <= R;     // When L is high, update Q with the value of R.
		else
			Q <= w;     // When L is low, update Q with the value of w.
	end
	// If E is low, the output Q holds its current state.
end

endmodule
