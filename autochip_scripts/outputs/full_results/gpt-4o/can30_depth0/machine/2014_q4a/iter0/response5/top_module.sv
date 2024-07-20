module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk or posedge R) begin
	if (R)
		Q <= 1'b0; // Reset Q to low state when R is high
	else if (E) begin
		if (L)
			Q <= R; // Update Q with value of R when L is high
		else
			Q <= w; // Update Q with value of w when L is low
	end
	// When E is low, maintain the current state of Q (no action needed as Q retains value)
end

endmodule
