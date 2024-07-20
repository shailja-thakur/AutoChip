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
			Q <= R;  // Load the value R into Q when L is asserted
		else if (E)
			Q <= w;  // Shift the input w into Q when E is asserted
	end

endmodule
