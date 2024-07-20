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
		Q <= R; // Load value R into Q
	end else if (E) begin
		Q <= w; // Shift w into Q when enabled
	end 
	// Otherwise, Q retains its value
end

endmodule
