module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (L)
		Q <= R;        // Load new value R to Q
	else if (E)
		Q <= w;        // Shift w to Q
end

endmodule
