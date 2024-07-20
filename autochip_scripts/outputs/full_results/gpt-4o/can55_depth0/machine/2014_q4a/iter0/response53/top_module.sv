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
		Q <= 0; // Reset the register
	else if (E) begin
		if (L)
			Q <= R; // Update with R if L is high
		else
			Q <= w; // Update with w if L is low
	end
    // When E is low, Q keeps its value
end

endmodule
