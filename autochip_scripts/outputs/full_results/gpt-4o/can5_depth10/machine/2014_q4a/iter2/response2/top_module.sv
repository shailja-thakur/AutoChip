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
		Q <= 0; // Reset output to low state
	else if (E) begin
		if (L)
			Q <= R; // Update Q with R if L is high (Q should follow R if L is high, but this is redundant as R takes precedence)
		else
			Q <= w; // Update Q with w if L is low
	end
	// If E is low, Q retains its value, no assignment needed in this case
end

endmodule
