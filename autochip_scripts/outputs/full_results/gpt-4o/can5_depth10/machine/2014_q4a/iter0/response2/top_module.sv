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
		Q <= 0; // Reset output to low state
	else if (E)
		if (L)
			Q <= R; // Update Q with R if L is high
		else
			Q <= w; // Update Q with w if L is low
end

endmodule
