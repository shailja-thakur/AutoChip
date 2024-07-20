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
			Q <= R;          // Load the value R into the flip-flop
		else if (E) 
			Q <= w;          // If enabled, shift in the value of w
	end

endmodule
