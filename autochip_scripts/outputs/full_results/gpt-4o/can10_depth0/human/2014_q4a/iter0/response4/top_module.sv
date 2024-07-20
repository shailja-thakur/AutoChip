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
		Q <= R; // Load the register with value R
	end
	else if (E) begin
		Q <= w; // Shift the input w into the register
	end
end

endmodule
