module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk) begin
		if (L) begin
			// Load the value R when L is asserted
			Q <= R;
		} else if (E) begin
			// Shift the value w into Q when E is enabled
			Q <= w;
		end
	end

endmodule
