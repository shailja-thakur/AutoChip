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
			Q <= R; // Load R into Q if L is high
		else if (E)
			Q <= w; // Shift w into Q if E is high
	end

endmodule
