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
			Q <= R; // If L is high, set Q to 0 because R is active high reset
		else
			Q <= w; // Update Q with w if L is low
	end
end

endmodule
