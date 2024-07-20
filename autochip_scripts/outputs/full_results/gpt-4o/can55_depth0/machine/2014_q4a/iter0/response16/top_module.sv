module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk) begin
		if (R) begin
			Q <= 0;  // Reset the output to 0
		end else if (E) begin
			if (L) begin
				Q <= R;  // Load R into the register
			else
				Q <= w;  // Load w into the register
			end
		end
	end

endmodule
